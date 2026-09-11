// components/loader.js - بارگذاری خودکار کامپوننت‌ها

const COMPONENT_BASE_URL = 'components/';

async function loadComponent(componentName, targetElementId) {
    try {
        const response = await fetch(`${COMPONENT_BASE_URL}${componentName}.html`);
        if (!response.ok) {
            throw new Error(`Failed to load ${componentName}`);
        }
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

async function loadAllComponents() {
    const components = [
        { name: 'header', target: 'headerContainer' },
        { name: 'sidebar', target: 'sidebarContainer' },
        { name: 'footer', target: 'footerContainer' }
    ];
    
    for (const comp of components) {
        await loadComponent(comp.name, comp.target);
    }
    
    // پس از بارگذاری، توابع مربوطه را مقداردهی کنید
    initHeaderFunctions();
    initSidebarFunctions();
    initFooterFunctions();
}

function initHeaderFunctions() {
    // توابع مربوط به هدر
    window.toggleNotifications = function() {
        const dropdown = document.getElementById('notificationsDropdown');
        if (dropdown) {
            dropdown.classList.toggle('show');
            loadNotifications();
        }
    };
    
    window.toggleUserMenu = function() {
        const dropdown = document.getElementById('userDropdown');
        if (dropdown) dropdown.classList.toggle('show');
    };
    
    window.changePassword = function() {
        window.location.href = 'profile.html?action=change-password';
    };
    
    window.logout = function() {
        localStorage.removeItem('currentUser');
        window.location.href = 'index.html';
    };
    
    // تنظیم تاریخ
    const now = new Date();
    const dateEl = document.getElementById('currentDate');
    if (dateEl) {
        dateEl.textContent = now.toLocaleDateString('fa-IR');
    }
    
    // تنظیم نام کاربر
    const user = JSON.parse(localStorage.getItem('currentUser'));
    const nameEl = document.getElementById('userName');
    if (user && nameEl) {
        nameEl.textContent = user.full_name;
    }
    
    // تنظیم زبان
    const savedLang = localStorage.getItem('userLanguage') || 'fa';
    const selector = document.getElementById('languageSelector');
    if (selector) {
        selector.value = savedLang;
        if (window.setLanguage) {
            window.setLanguage(savedLang);
        }
    }
}

function initSidebarFunctions() {
    // فعال کردن آیتم فعال در سایدبار
    const currentPage = window.location.pathname.split('/').pop() || 'dashboard.html';
    const menuMap = {
        'dashboard.html': 'dashboard',
        'ncr-list.html': 'ncr-list',
        'new-ncr.html': 'new-ncr',
        'claim-form.html': 'claim',
        'shortage-form.html': 'shortage',
        'purchase-request.html': 'purchase',
        'corrective-action.html': 'corrective-action',
        'users.html': 'users',
        'notifications.html': 'notifications',
        'settings.html': 'settings'
    };
    
    const activeMenu = menuMap[currentPage] || 'dashboard';
    document.querySelectorAll('.sidebar-nav a').forEach(link => {
        link.classList.remove('active');
        if (link.dataset.menu === activeMenu) {
            link.classList.add('active');
        }
    });
}

function initFooterFunctions() {
    const yearEl = document.getElementById('footerYear');
    if (yearEl) {
        yearEl.textContent = new Date().getFullYear();
    }
    
    window.showAbout = function() {
        alert('📋 سیستم مدیریت عدم انطباق (NCR)\nنسخه 2.0\nمطابق با استاندارد ISO 9001:2015');
    };
    
    window.showHelp = function() {
        alert('راهنمای سیستم:\n1. برای ثبت NCR جدید از منوی "ثبت NCR جدید" استفاده کنید.\n2. برای مشاهده لیست NCRها به "لیست NCRها" مراجعه کنید.\n3. هر NCR در 4 مرحله تکمیل می‌شود.');
    };
}

// بارگذاری کامپوننت‌ها هنگام بارگذاری صفحه
document.addEventListener('DOMContentLoaded', function() {
    loadAllComponents();
});

// صادر کردن توابع برای استفاده در صفحات
window.loadAllComponents = loadAllComponents;
window.loadComponent = loadComponent;