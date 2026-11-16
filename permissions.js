// permissions.js - سیستم مدیریت دسترسی‌های پویا
// ============================================

const PERMISSIONS_API = window.NCR_API + '/';

// ============================================
// متغیرهای سراسری
// ============================================
window.USER_PERMISSIONS = [];
window.USER_ROLE = null;
window.PERMISSIONS_LOADED = false;

// ============================================
// دریافت دسترسی‌های کاربر جاری
// ============================================
window.loadUserPermissions = async function() {
    try {
        const userStr = localStorage.getItem('currentUser');
        if (!userStr) {
            console.warn('⚠️ No currentUser in localStorage');
            return false;
        }
        
        const user = JSON.parse(userStr);
        const userId = parseInt(user.id);
        
        if (!userId) {
            console.warn('⚠️ No user id');
            return false;
        }
        
        console.log('🔐 Loading permissions for user:', userId);
        
        const response = await fetch(PERMISSIONS_API + 'get_user_permissions.php?user_id=' + userId);
        const result = await response.json();
        
        if (!result.success) {
            console.error('❌ Failed to load permissions:', result.error);
            const cached = localStorage.getItem('userPermissions');
            if (cached) {
                window.USER_PERMISSIONS = JSON.parse(cached);
                window.USER_ROLE = localStorage.getItem('userRole');
                window.PERMISSIONS_LOADED = true;
                return true;
            }
            return false;
        }
        
        window.USER_PERMISSIONS = result.permissions || [];
        window.USER_ROLE = result.user.role;
        window.PERMISSIONS_LOADED = true;
        
        // ⭐ ذخیره نام نمایشی نقش
        if (result.user.role_display) {
            localStorage.setItem('userRoleDisplay', result.user.role_display);
        }
        
        // ⭐ ذخیره همه نقش‌ها (برای استفاده در هدر)
        if (result.roles) {
            localStorage.setItem('allRoles', JSON.stringify(result.roles));
        }
        
        localStorage.setItem('userPermissions', JSON.stringify(window.USER_PERMISSIONS));
        localStorage.setItem('userRole', window.USER_ROLE);
        
        console.log('✅ Permissions loaded:', window.USER_PERMISSIONS.length);
        console.log('✅ Role:', window.USER_ROLE);
        
        return true;
    } catch (error) {
        console.error('❌ loadUserPermissions error:', error);
        
        const cached = localStorage.getItem('userPermissions');
        if (cached) {
            window.USER_PERMISSIONS = JSON.parse(cached);
            window.USER_ROLE = localStorage.getItem('userRole');
            window.PERMISSIONS_LOADED = true;
            console.log('📦 Using cached permissions');
            return true;
        }
        
        return false;
    }
};

// ============================================
// بررسی دسترسی
// ============================================
window.hasPermission = function(permissionCode) {
    if (window.USER_ROLE === 'admin') return true;
    return window.USER_PERMISSIONS.includes(permissionCode);
};

window.hasAnyPermission = function(permissionCodes) {
    if (window.USER_ROLE === 'admin') return true;
    return permissionCodes.some(code => window.USER_PERMISSIONS.includes(code));
};

window.hasAllPermissions = function(permissionCodes) {
    if (window.USER_ROLE === 'admin') return true;
    return permissionCodes.every(code => window.USER_PERMISSIONS.includes(code));
};

window.hasRole = function(roleName) {
    if (Array.isArray(roleName)) {
        return roleName.includes(window.USER_ROLE);
    }
    return window.USER_ROLE === roleName;
};

// ============================================
// بررسی دسترسی ویرایش مرحله NCR
// ============================================
window.canEditNCRStep = function(step, ncrData) {
    const user = JSON.parse(localStorage.getItem('currentUser') || 'null');
    if (!user) return false;
    
    const userRole = user.role;
    if (userRole === 'admin') return true;
    if (ncrData.status === 'closed') return false;
    
    if (step === 1) {
        if (ncrData.step2_submitted_at) return false;
        return window.hasPermission('ncr.create') || window.hasPermission('ncr.edit_draft');
    }
    if (step === 2) {
        if (ncrData.step3_submitted_at) return false;
        return window.hasPermission('ncr.approve_step2');
    }
    if (step === 3) {
        if (ncrData.step4_submitted_at) return false;
        return window.hasPermission('ncr.approve_step3');
    }
    if (step === 4) {
        return window.hasPermission('ncr.close');
    }
    return false;
};

window.canAccessNCRStep = function(step, ncrData) {
    const user = JSON.parse(localStorage.getItem('currentUser') || 'null');
    if (!user) return false;
    
    const userRole = user.role;
    if (userRole === 'admin') return true;
    if (step === 1) return true;
    if (ncrData.status === 'closed') return true;
    
    if (step === 2) return window.hasPermission('ncr.approve_step2') || window.hasPermission('ncr.approve_step3');
    if (step === 3) return window.hasPermission('ncr.approve_step3');
    if (step === 4) return window.hasPermission('ncr.close');
    
    return false;
};

// ============================================
// فیلتر کردن منوها بر اساس دسترسی
// ============================================
window.filterMenuByPermissions = function() {
    const menuPermissions = {
        'dashboard': null,
        'ncr-list': 'ncr.list',
        'new-ncr': 'ncr.create',
        'claim': 'claim.list',
        'shortage': 'shortage.list',
        'purchase': 'pr.approve',
        'corrective-action': 'ncr.list',
        'users': 'user.manage',
        'notifications': null,
        'settings': null
    };
    
    document.querySelectorAll('.sidebar-nav a[data-menu]').forEach(link => {
        const menuName = link.dataset.menu;
        const requiredPermission = menuPermissions[menuName];
        
        if (requiredPermission && !window.hasPermission(requiredPermission)) {
            link.style.display = 'none';
        } else {
            link.style.display = 'flex';
        }
    });
};

// ============================================
// اعمال دسترسی روی دکمه‌ها
// ============================================
window.applyButtonPermissions = function() {
    document.querySelectorAll('[data-permission]').forEach(el => {
        const permission = el.dataset.permission;
        if (!window.hasPermission(permission)) {
            el.style.display = 'none';
        } else {
            el.style.display = '';
        }
    });
};

console.log('✅ permissions.js loaded');