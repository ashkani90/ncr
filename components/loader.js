// components/loader.js - نسخه نهایی اصلاح‌شده
// ============================================

const COMPONENT_BASE_URL = 'components/';

// ⭐ لود اسکریپت به‌صورت داینامیک
function loadScript(src) {
    return new Promise((resolve, reject) => {
        const baseSrc = src.split('?')[0];
        if (document.querySelector(`script[src^="${baseSrc}"]`)) {
            console.log('✅ Script already loaded:', src);
            resolve();
            return;
        }
        const script = document.createElement('script');
        script.src = src;
        script.onload = () => {
            console.log('✅ Script loaded:', src);
            resolve();
        };
        script.onerror = () => reject(new Error('Failed to load ' + src));
        document.head.appendChild(script);
    });
}

async function loadComponent(componentName, targetElementId) {
    try {
        const response = await fetch(`${COMPONENT_BASE_URL}${componentName}.html`);
        if (!response.ok) throw new Error(`Failed to load ${componentName}`);
        const html = await response.text();
        const target = document.getElementById(targetElementId);
        if (target) {
            target.innerHTML = html;
            return true;
        }
        return false;
    } catch (error) {
        console.error(`Error loading component ${componentName}:`, error);
        return false;
    }
}

// ⭐ متغیر برای ذخیره interval
let _notificationPollingInterval = null;

function startNotificationPolling() {
    if (_notificationPollingInterval) {
        clearInterval(_notificationPollingInterval);
    }
    _notificationPollingInterval = setInterval(function() {
        if (typeof window.updateNotifications === 'function') {
            window.updateNotifications();
        }
    }, 30000);
}

// ⭐ نسخه واحد loadAllComponents
async function loadAllComponents() {
    console.log('🚀 loadAllComponents started');
    
    // ⭐ ۱) اول permissions.js را لود کن
    try {
        await loadScript('permissions.js?v=20261101');
        if (typeof window.loadUserPermissions === 'function') {
            await window.loadUserPermissions();
            console.log('✅ User permissions loaded');
        }
    } catch (e) {
        console.error('❌ Failed to load permissions.js:', e);
    }
    
    // ⭐ ۲) سپس component-utils.js را لود کن
    try {
        await loadScript('components/component-utils.js?v=20261101');
        console.log('✅ component-utils.js loaded');
    } catch (e) {
        console.error('❌ Failed to load component-utils.js:', e);
    }

    // ⭐ ۳) کامپوننت‌های HTML را لود کن
    const components = [
        { name: 'header', target: 'headerContainer' },
        { name: 'sidebar', target: 'sidebarContainer' },
        { name: 'footer', target: 'footerContainer' }
    ];

    for (const comp of components) {
        await loadComponent(comp.name, comp.target);
    }

    // ⭐ ۴) توابع اولیه را تنظیم کن
    initHeaderFunctions();
    initSidebarFunctions();
    initFooterFunctions();
    
    // ⭐⭐⭐ ۵) به‌روزرسانی Breadcrumb (NEW!)
    updateBreadcrumb();
    updateHeaderTitle();

    // ⭐ ۶) نمایش نقش
    console.log('🎯 Calling updateUserRoleBadge after header loaded...');
    const user = JSON.parse(localStorage.getItem('currentUser'));
    if (user) {
        updateUserRoleBadge(user);
    }

    // ⭐ ۷) اعمال دسترسی‌ها
    if (typeof window.filterMenuByPermissions === 'function') {
        window.filterMenuByPermissions();
    }
    if (typeof window.applyButtonPermissions === 'function') {
        window.applyButtonPermissions();
    }

    // ⭐ ۸) اعلان‌ها
    if (typeof window.updateNotifications === 'function') {
        try {
            await window.updateNotifications();
        } catch (e) {
            console.error('❌ updateNotifications error:', e);
        }
    }

    // ⭐ ۹) شروع polling
    startNotificationPolling();
    
    console.log('✅ loadAllComponents completed');
}

// ============================================
// ⭐⭐⭐ تابع به‌روزرسانی Breadcrumb (NEW!)
// ============================================
function updateBreadcrumb() {
    const currentPage = window.location.pathname.split('/').pop() || 'dashboard.html';
    
    // ⭐ نقشه‌برداری صفحه به اطلاعات Breadcrumb
    const pageMap = {
        'dashboard.html': { menu: 'dashboard', title: 'داشبورد', titleEn: 'Dashboard', i18nKey: 'menu_dashboard' },
        'ncr-list.html': { menu: 'ncr-list', title: 'لیست NCRها', titleEn: 'NCR List', i18nKey: 'menu_ncr_list' },
        'new-ncr.html': { menu: 'new-ncr', title: 'ثبت NCR جدید', titleEn: 'New NCR', i18nKey: 'menu_new_ncr' },
        'claim-form.html': { menu: 'claim', title: 'کلیم قطعه', titleEn: 'Claim', i18nKey: 'menu_claim' },
        'shortage-form.html': { menu: 'shortage', title: 'عدم ارسال قطعه', titleEn: 'Shortage', i18nKey: 'menu_shortage' },
        'purchase-request.html': { menu: 'purchase', title: 'درخواست خرید', titleEn: 'Purchase Request', i18nKey: 'menu_purchase' },
        'corrective-action.html': { menu: 'corrective-action', title: 'اقدام اصلاحی/پیشگیرانه', titleEn: 'Corrective Action', i18nKey: null },
        'users.html': { menu: 'users', title: 'مدیریت کاربران', titleEn: 'User Management', i18nKey: 'menu_users' },
        'add-user.html': { menu: 'users', title: 'افزودن کاربر جدید', titleEn: 'Add New User', i18nKey: 'add_user_title' },
        'notifications.html': { menu: 'notifications', title: 'اعلان‌ها', titleEn: 'Notifications', i18nKey: 'menu_notifications' },
        'settings.html': { menu: 'settings', title: 'تنظیمات', titleEn: 'Settings', i18nKey: 'menu_settings' },
        'profile.html': { menu: 'users', title: 'پروفایل کاربری', titleEn: 'User Profile', i18nKey: 'profile' },
        'change-password.html': { menu: 'users', title: 'تغییر رمز عبور', titleEn: 'Change Password', i18nKey: 'change_password' },
        'ncr-detail.html': { menu: 'ncr-list', title: 'جزئیات NCR', titleEn: 'NCR Detail', i18nKey: null },
        '00-ncr-detail.html': { menu: 'ncr-list', title: 'جزئیات NCR', titleEn: 'NCR Detail', i18nKey: null },
        
        // ⭐ این سه مورد را بدون کامای اضافی در انتها بنویسید
        'claim-list.html': { menu: 'claim-list', title: 'لیست کلیم‌ها', titleEn: 'Claim List', i18nKey: 'claim_list_title' },
        'purchase-list.html': { menu: 'purchase-list', title: 'لیست درخواست‌های خرید', titleEn: 'Purchase List', i18nKey: 'purchase_list_title' },
        'ca-list.html': { menu: 'ca-list', title: 'لیست اقدامات اصلاحی', titleEn: 'CA List', i18nKey: 'ca_list_title' }
    }; // <--- اینجا نباید کاما باشد
    
    const pageInfo = pageMap[currentPage] || {
        menu: 'dashboard',
        title: 'داشبورد',
        titleEn: 'Dashboard',
        i18nKey: 'menu_dashboard'
    };
    
    // ⭐ تشخیص زبان جاری
    const currentLang = localStorage.getItem('userLanguage') || 'fa';
    const isEditUserPage = currentPage === 'add-user.html' &&
        new URLSearchParams(window.location.search).has('id');
    const displayTitle = isEditUserPage && window.t
        ? window.t('edit_user_title')
        : ((window.t && pageInfo.i18nKey)
            ? window.t(pageInfo.i18nKey)
            : (currentLang === 'en' ? pageInfo.titleEn : pageInfo.title));
    
    // ⭐ به‌روزرسانی Breadcrumb اصلی (id=breadcrumb)
    const breadcrumb = document.getElementById('breadcrumb');
    if (breadcrumb) {
        const dashboardLabel = (window.t ? window.t('menu_dashboard') : (currentLang === 'en' ? 'Dashboard' : 'داشبورد'));
        // ساخت HTML جدید
        breadcrumb.innerHTML = `
            <a href="dashboard.html" ${pageInfo.menu !== 'dashboard' ? '' : 'style="color:#667eea;font-weight:600;"'}>
                ${dashboardLabel}
            </a>
            ${pageInfo.menu !== 'dashboard' ? `
                <span class="separator">/</span>
                <span class="current" id="pageTitle">${displayTitle}</span>
            ` : ''}
        `;
        
        console.log('✅ Breadcrumb updated:', pageInfo.menu, '|', displayTitle);
    }
    
    // ⭐ به‌روزرسانی عنوان هدر مرکزی (id=headerTitle)
    const headerTitle = document.getElementById('headerTitle');
    if (headerTitle) {
        headerTitle.textContent = displayTitle + (currentLang === 'fa' ? ' مدیریت' : '');
        console.log('✅ Header title updated:', headerTitle.textContent);
    }
    
    // ⭐ به‌روزرسانی عنوان صفحه HTML
    const baseTitle = (window.t ? window.t('login_title') : 'سیستم مدیریت عدم انطباق');
    document.title = displayTitle + ' | ' + baseTitle;
    
    // ⭐ به‌روزرسانی id=pageTitle اگر وجود داشت
    const pageTitleEl = document.getElementById('pageTitle');
    if (pageTitleEl) {
        pageTitleEl.textContent = displayTitle;
    }
    
    console.log('📍 Current page:', currentPage);
    console.log('📍 Page info:', pageInfo);
}

// ============================================
// ⭐ به‌روزرسانی فقط عنوان هدر
// ============================================
function updateHeaderTitle() {
    const currentPage = window.location.pathname.split('/').pop() || 'dashboard.html';

    const titleKeyMap = {
        'dashboard.html': 'dashboard_title',
        'ncr-list.html': 'ncr_list_title',
        'new-ncr.html': 'new_ncr_title',
        'claim-form.html': 'menu_claim',
        'claim-list.html': 'claim_list_title',
        'shortage-form.html': 'menu_shortage',
        'purchase-request.html': 'menu_purchase',
        'purchase-list.html': 'purchase_list_title',
        'corrective-action.html': 'menu_corrective_action',
        'ca-list.html': 'ca_list_title',
        'users.html': 'menu_users',
        'add-user.html': 'add_user_title',
        'notifications.html': 'menu_notifications',
        'settings.html': 'menu_settings',
        'profile.html': 'profile',
        'change-password.html': 'change_password',
        'ncr-detail.html': 'menu_ncr_list'
    };

    const titleMap = {
        'dashboard.html': { fa: 'داشبورد مدیریت', en: 'Dashboard' },
        'ncr-list.html': { fa: 'لیست NCRها', en: 'NCR List' },
        'new-ncr.html': { fa: 'ثبت NCR جدید', en: 'New NCR' },
        'claim-form.html': { fa: 'فرم کلیم قطعه', en: 'Claim Form' },
        'claim-list.html': { fa: 'لیست کلیم‌ها', en: 'Claim List' },
        'shortage-form.html': { fa: 'عدم ارسال قطعه', en: 'Shortage' },
        'purchase-request.html': { fa: 'درخواست خرید', en: 'Purchase Request' },
        'purchase-list.html': { fa: 'لیست درخواست‌های خرید', en: 'Purchase List' },
        'corrective-action.html': { fa: 'اقدام اصلاحی و بهبود', en: 'Corrective Action' },
        'ca-list.html': { fa: 'لیست اقدامات اصلاحی', en: 'CA List' },
        'users.html': { fa: 'مدیریت کاربران', en: 'User Management' },
        'notifications.html': { fa: 'اعلان‌ها', en: 'Notifications' },
        'settings.html': { fa: 'تنظیمات سیستم', en: 'Settings' },
        'profile.html': { fa: 'پروفایل کاربری', en: 'Profile' },
        'ncr-detail.html': { fa: 'جزئیات NCR', en: 'NCR Detail' }
    };

    const currentLang = localStorage.getItem('userLanguage') || 'fa';
    const headerTitle = document.getElementById('headerTitle');
    if (!headerTitle) return;

    const key = titleKeyMap[currentPage];
    if (key && window.t) {
        const editUser = currentPage === 'add-user.html' &&
            new URLSearchParams(window.location.search).has('id');
        headerTitle.textContent = editUser ? window.t('edit_user_title') : window.t(key);
        return;
    }

    const titles = titleMap[currentPage] || titleMap['dashboard.html'];
    headerTitle.textContent = currentLang === 'en' ? titles.en : titles.fa;
}

function initHeaderFunctions() {
    window.toggleNotifications = function() {
        const dropdown = document.getElementById('notificationsDropdown');
        if (dropdown) {
            dropdown.classList.toggle('show');
            if (dropdown.classList.contains('show') && typeof window.loadNotifications === 'function') {
                window.loadNotifications();
            }
        }
    };

    window.toggleUserMenu = function() {
        const dropdown = document.getElementById('userDropdown');
        if (dropdown) dropdown.classList.toggle('show');
    };

    window.changePassword = function() {
        window.location.href = 'change-password.html';
    };

    window.logout = function() {
        localStorage.removeItem('currentUser');
        localStorage.removeItem('userPermissions');
        localStorage.removeItem('userRole');
        localStorage.removeItem('userRoleDisplay');
        localStorage.removeItem('allRoles');
        window.location.href = 'index.html';
    };

    // ⭐ تاریخ (بر اساس زبان جاری)
    updateHeaderDate();

    // ⭐ نام کاربر
    const user = JSON.parse(localStorage.getItem('currentUser'));
    const nameEl = document.getElementById('userName');
    if (user && nameEl) nameEl.textContent = user.full_name;

    // ⭐ تصویر کاربر در هدر
    updateHeaderAvatar(user);

    // ⭐ نمایش نقش کاربر
    updateUserRoleBadge(user);

    // ⭐ زبان
    const savedLang = localStorage.getItem('userLanguage') || 'fa';
    const selector = document.getElementById('languageSelector');
    if (selector) {
        selector.value = savedLang;
        if (window.setLanguage) window.setLanguage(savedLang);
    }

    setupOutsideClickListener();
}

// ============================================
// ⭐ نمایش تصویر کاربر در هدر
// ============================================
function updateHeaderAvatar(user) {
    const img = document.getElementById('userAvatar');
    if (!img || !user || !user.avatar) return;

    const avatar = String(user.avatar);
    img.src = /^(https?:|data:|\/)/.test(avatar)
        ? avatar
        : ((window.NCR_ROOT || '') + avatar);
}

window.updateHeaderAvatar = updateHeaderAvatar;

// ============================================
// ⭐ تابع نمایش نقش کاربر از دیتابیس
// ============================================
function updateUserRoleBadge(user) {
    console.log('🎯 updateUserRoleBadge called with user:', user);
    
    const roleEl = document.getElementById('userRole');
    if (!roleEl) {
        console.warn('⚠️ userRole element not found in header!');
        return;
    }
    
    console.log('✅ Found userRole element');
    
    if (!user || !user.role) {
        console.warn('⚠️ No user or role');
        roleEl.textContent = '-';
        return;
    }
    
    console.log('👤 User role:', user.role);
    
    // ⭐ روش ۱: خواندن از localStorage
    const cachedDisplay = localStorage.getItem('userRoleDisplay');
    console.log('📦 Cached display:', cachedDisplay);
    
    if (cachedDisplay && cachedDisplay.trim()) {
        roleEl.textContent = cachedDisplay;
        roleEl.className = 'user-role-badge role-' + user.role;
        console.log('✅ Role badge set from cache:', cachedDisplay);
        return;
    }
    
    // ⭐ روش ۲: خواندن از allRoles
    const allRolesStr = localStorage.getItem('allRoles');
    console.log('📦 allRoles:', allRolesStr);
    
    if (allRolesStr) {
        try {
            const allRoles = JSON.parse(allRolesStr);
            const role = allRoles.find(r => r.name === user.role);
            console.log('🔍 Found role in allRoles:', role);
            
            if (role && role.description) {
                roleEl.textContent = role.description;
                roleEl.className = 'user-role-badge role-' + user.role;
                localStorage.setItem('userRoleDisplay', role.description);
                console.log('✅ Role badge set from allRoles:', role.description);
                return;
            }
        } catch (e) {
            console.warn('⚠️ Could not parse allRoles:', e);
        }
    }
    
    // ⭐ روش ۳: از دیتابیس
    console.log('📡 Fetching role display from DB...');
    roleEl.textContent = user.role;
    roleEl.className = 'user-role-badge role-' + user.role;
    
    fetchRoleDisplayFromDB(user).then(displayName => {
        console.log('📡 DB returned display name:', displayName);
        if (displayName && roleEl) {
            roleEl.textContent = displayName;
            localStorage.setItem('userRoleDisplay', displayName);
            console.log('✅ Role badge set from DB:', displayName);
        }
    });
}

// ============================================
// ⭐ دریافت نام نمایشی نقش از دیتابیس
// ============================================
async function fetchRoleDisplayFromDB(user) {
    try {
        const userId = parseInt(user.id);
        if (!userId) return null;
        
        const res = await fetch(window.NCR_API + '/get_user_permissions.php?user_id=' + userId);
        const result = await res.json();
        
        if (result.success && result.user && result.user.role_display) {
            if (result.roles) {
                localStorage.setItem('allRoles', JSON.stringify(result.roles));
            }
            return result.user.role_display;
        }
        return null;
    } catch (e) {
        console.error('❌ fetchRoleDisplayFromDB error:', e);
        return null;
    }
}

// ⭐ صادرات
window.updateUserRoleBadge = updateUserRoleBadge;
window.fetchRoleDisplayFromDB = fetchRoleDisplayFromDB;
window.updateBreadcrumb = updateBreadcrumb;
window.updateHeaderTitle = updateHeaderTitle;

function setupOutsideClickListener() {
    if (window._outsideClickHandler) {
        document.removeEventListener('click', window._outsideClickHandler);
    }

    window._outsideClickHandler = function(e) {
        const notifDropdown = document.getElementById('notificationsDropdown');
        if (notifDropdown && notifDropdown.classList.contains('show')) {
            if (!e.target.closest('.header-notifications')) {
                notifDropdown.classList.remove('show');
            }
        }

        const userDropdown = document.getElementById('userDropdown');
        if (userDropdown && userDropdown.classList.contains('show')) {
            if (!e.target.closest('.user-profile')) {
                userDropdown.classList.remove('show');
            }
        }
    };

    document.addEventListener('click', window._outsideClickHandler);
}

// ============================================
// ⭐ توابع سایدبار - شامل toggleSidebar
// ============================================
function initSidebarFunctions() {
    // ⭐ تنظیم منوی فعال
    const currentPage = window.location.pathname.split('/').pop() || 'dashboard.html';
    const menuMap = {
        'dashboard.html': 'dashboard',
        'ncr-list.html': 'ncr-list',
        'new-ncr.html': 'new-ncr',
        'claim-form.html': 'claim',
        'claim-list.html': 'claim-list', // ⭐ اضافه شد
        'shortage-form.html': 'shortage',
        'purchase-request.html': 'purchase',
        'purchase-list.html': 'purchase-list', // ⭐ اضافه شد
        'corrective-action.html': 'corrective-action',
        'ca-list.html': 'ca-list', // ⭐ اضافه شد
        'users.html': 'users',
        'add-user.html': 'users',
        'notifications.html': 'notifications',
        'settings.html': 'settings',
        'profile.html': 'users',
        'change-password.html': 'users',
        'ncr-detail.html': 'ncr-list',
        '00-ncr-detail.html': 'ncr-list'
    };

    const activeMenu = menuMap[currentPage] || 'dashboard';
    document.querySelectorAll('.sidebar-nav a').forEach(link => {
        link.classList.remove('active');
        if (link.dataset.menu === activeMenu) link.classList.add('active');
    });

    // ⭐⭐⭐ تعریف toggleSidebar در سطح global
    window.toggleSidebar = function() {
        const sidebar = document.getElementById('sidebar');
        const mainContent = document.getElementById('mainContent');

        if (!sidebar) {
            console.warn('⚠️ sidebar element not found');
            return;
        }

        ensureSidebarBackdrop();

        // ⭐ Toggle کلاس‌ها (باز و بسته نباید هم‌زمان باشند)
        const isMobile = window.innerWidth < 768;
        const isOpening = isMobile
            ? !sidebar.classList.contains('open')
            : sidebar.classList.contains('collapsed');

        if (isOpening) {
            sidebar.classList.add('open');
            sidebar.classList.remove('collapsed');
            if (mainContent) mainContent.classList.remove('expanded');
            if (isMobile) document.body.classList.add('sidebar-open');
        } else {
            sidebar.classList.remove('open');
            sidebar.classList.add('collapsed');
            if (mainContent) mainContent.classList.add('expanded');
            document.body.classList.remove('sidebar-open');
        }

        // ⭐ ذخیره وضعیت در localStorage
        localStorage.setItem('sidebarState', isOpening ? 'open' : 'closed');

        console.log('✅ Sidebar toggled:', isOpening ? 'opened' : 'closed');
    };

    // ⭐ بستن سایدبار در موبایل هنگام کلیک روی لینک
    document.querySelectorAll('.sidebar-nav a').forEach(link => {
        link.addEventListener('click', function() {
            if (window.innerWidth < 768) {
                const sidebar = document.getElementById('sidebar');
                const mainContent = document.getElementById('mainContent');
                if (sidebar && sidebar.classList.contains('open')) {
                    sidebar.classList.remove('open');
                    sidebar.classList.remove('collapsed');
                    if (mainContent) mainContent.classList.remove('expanded');
                    document.body.classList.remove('sidebar-open');
                }
            }
        });
    });
}

// ⭐ پرده پشت سایدبار برای موبایل
function ensureSidebarBackdrop() {
    if (document.querySelector('.sidebar-backdrop')) return;

    const backdrop = document.createElement('div');
    backdrop.className = 'sidebar-backdrop';
    backdrop.addEventListener('click', function() {
        if (typeof window.toggleSidebar === 'function') {
            window.toggleSidebar();
        }
    });
    document.body.appendChild(backdrop);
}

// ⭐ نمایش تاریخ هدر بر اساس زبان جاری
function updateHeaderDate() {
    const dateEl = document.getElementById('currentDate');
    if (!dateEl) return;

    const lang = localStorage.getItem('userLanguage') || 'fa';
    const localeMap = { fa: 'fa-IR', en: 'en-GB', zh: 'zh-CN' };
    const locale = localeMap[lang] || 'fa-IR';

    try {
        dateEl.textContent = new Date().toLocaleDateString(locale);
    } catch (e) {
        dateEl.textContent = new Date().toLocaleDateString();
    }
}

window.updateHeaderDate = updateHeaderDate;

// ⭐ با تغییر زبان، تاریخ و عنوان‌ها هم به‌روزرسانی شوند
document.addEventListener('languagechange', function() {
    updateHeaderDate();
    if (typeof updateBreadcrumb === 'function') updateBreadcrumb();
    if (typeof updateHeaderTitle === 'function') updateHeaderTitle();
});

function initFooterFunctions() {
    const yearEl = document.getElementById('footerYear');
    if (yearEl) yearEl.textContent = new Date().getFullYear();

    window.showAbout = function() {
        alert('📋 سیستم مدیریت عدم انطباق (NCR)\nنسخه 2.0\nمطابق با استاندارد ISO 9001:2015');
    };
    window.showHelp = function() {
        alert('راهنمای سیستم:\n1. برای ثبت NCR جدید از منوی "ثبت NCR جدید" استفاده کنید.\n2. برای مشاهده لیست NCRها به "لیست NCRها" مراجعه کنید.\n3. هر NCR در 4 مرحله تکمیل می‌شود.');
    };
}

// ⭐ اجرا خودکار
document.addEventListener('DOMContentLoaded', function() {
    loadAllComponents();
});

// ⭐ اگر اسکریپت بعد از DOMContentLoaded لود شد
if (document.readyState !== 'loading') {
    setTimeout(function() {
        if (!document.getElementById('headerContainer')?.innerHTML) {
            loadAllComponents();
        }
    }, 100);
}

window.loadAllComponents = loadAllComponents;
window.loadComponent = loadComponent;
window.startNotificationPolling = startNotificationPolling;

console.log('✅ loader.js loaded');