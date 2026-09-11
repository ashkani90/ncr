// app.js - منطق اصلی برنامه با اتصال به دیتابیس

// ============================================
// توابع عمومی
// ============================================

// دریافت اطلاعات کاربر جاری
function getCurrentUser() {
    return JSON.parse(localStorage.getItem('currentUser'));
}

// بررسی دسترسی کاربر
function checkPermission(requiredRole) {
    const user = getCurrentUser();
    if (!user) {
        window.location.href = 'index.html';
        return false;
    }
    if (requiredRole && user.role !== requiredRole && user.role !== 'admin') {
        alert('شما دسترسی لازم برای این عملیات را ندارید!');
        return false;
    }
    return true;
}

// نمایش تاریخ جاری
function displayCurrentDate() {
    const now = new Date();
    const options = { year: 'numeric', month: '2-digit', day: '2-digit' };
    return now.toLocaleDateString('fa-IR', options);
}

// تولید شماره منحصر‌به‌فرد
async function generateUniqueNumber(prefix, storageKey) {
    // برای NCR از دیتابیس استفاده می‌کنیم
    if (storageKey === 'ncrs') {
        const ncrs = await getAllNCRs();
        const date = new Date();
        const year = date.getFullYear();
        const count = ncrs.length + 1;
        return `${prefix}-${year}-${String(count).padStart(4, '0')}`;
    }
    
    // برای سایر موارد از localStorage
    const data = JSON.parse(localStorage.getItem(storageKey) || '[]');
    const date = new Date();
    const year = date.getFullYear();
    const count = data.length + 1;
    return `${prefix}-${year}-${String(count).padStart(3, '0')}`;
}

// ============================================
// صادرات توابع به window
// ============================================

window.getCurrentUser = getCurrentUser;
window.checkPermission = checkPermission;
window.displayCurrentDate = displayCurrentDate;
window.generateUniqueNumber = generateUniqueNumber;