// components/component-utils.js - توابع کمکی برای کامپوننت‌ها

// تنظیم عنوان صفحه و بریدکِرامب
function setPageTitle(title, breadcrumb = null) {
    const titleEl = document.getElementById('pageTitle');
    const headerTitle = document.getElementById('headerTitle');
    const breadcrumbEl = document.getElementById('breadcrumb');
    
    if (titleEl) titleEl.textContent = title;
    if (headerTitle) headerTitle.textContent = title;
    
    if (breadcrumb && breadcrumbEl) {
        // به‌روزرسانی بریدکِرامب
        const currentSpan = breadcrumbEl.querySelector('.current');
        if (currentSpan) {
            currentSpan.textContent = breadcrumb;
        }
    }
}

// به‌روزرسانی اعلان‌ها
function updateNotifications() {
    const notifications = JSON.parse(localStorage.getItem('notifications') || '[]');
    const unread = notifications.filter(n => !n.is_read);
    const badge = document.getElementById('notificationBadge');
    if (badge) {
        badge.textContent = unread.length;
        badge.style.display = unread.length > 0 ? 'block' : 'none';
    }
}

// بارگذاری اعلان‌ها در dropdown
function loadNotifications() {
    const list = document.getElementById('notificationList');
    if (!list) return;
    
    const notifications = JSON.parse(localStorage.getItem('notifications') || '[]');
    
    if (notifications.length === 0) {
        list.innerHTML = '<div class="no-notifications" data-i18n="no_notifications">هیچ اعلان جدیدی وجود ندارد</div>';
        return;
    }
    
    const unread = notifications.filter(n => !n.is_read);
    const showNotifications = unread.length > 0 ? unread : notifications.slice(0, 5);
    
    let html = '';
    showNotifications.slice(0, 5).forEach(function(n) {
        const iconMap = { info: 'fa-info-circle', success: 'fa-check-circle', warning: 'fa-exclamation-triangle', danger: 'fa-exclamation-circle' };
        const icon = iconMap[n.type] || 'fa-info-circle';
        const unreadClass = n.is_read ? '' : 'unread';
        
        html += '<div class="notification-item ' + unreadClass + '" data-id="' + n.id + '" onclick="markNotificationRead(' + n.id + ')">';
        html += '  <div class="notification-icon ' + n.type + '"><i class="fas ' + icon + '"></i></div>';
        html += '  <div class="notification-content">';
        html += '    <div class="notification-title">' + n.title + '</div>';
        html += '    <div class="notification-message">' + n.message + '</div>';
        html += '    <div class="notification-time">' + n.created_at + '</div>';
        html += '  </div>';
        html += '</div>';
    });
    
    if (notifications.length > 5) {
        html += '<div style="text-align:center;padding:10px;color:#6c757d;font-size:13px;">و ' + (notifications.length - 5) + ' اعلان دیگر...</div>';
    }
    
    list.innerHTML = html;
}

// علامت‌گذاری اعلان به عنوان خوانده شده
function markNotificationRead(id) {
    const notifications = JSON.parse(localStorage.getItem('notifications') || '[]');
    const found = notifications.find(n => n.id === id);
    if (found) {
        found.is_read = true;
        localStorage.setItem('notifications', JSON.stringify(notifications));
        updateNotifications();
        loadNotifications();
    }
}

// صادر کردن توابع
window.setPageTitle = setPageTitle;
window.updateNotifications = updateNotifications;
window.loadNotifications = loadNotifications;
window.markNotificationRead = markNotificationRead;