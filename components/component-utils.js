// components/component-utils.js - نسخه نهایی اصلاح‌شده

const API_BASE = window.NCR_API + '/';

// ============================================
// دریافت user_id صحیح از کاربر جاری
// ⭐⭐⭐ همیشه از user.id استفاده می‌کنیم (نه user.user_id)
// ============================================
function getCurrentUserId() {
    try {
        const userStr = localStorage.getItem('currentUser');
        if (!userStr) {
            console.warn('⚠️ No currentUser in localStorage');
            return 0;
        }
        
        const user = JSON.parse(userStr);
        
        // ⭐⭐⭐ حتماً user.id را برگردان (نه user.user_id)
        // user.id = 2 (کلید اصلی جدول users)
        // user.user_id = 1002 (کد پرسنلی)
        // ما در notifications از user.id استفاده می‌کنیم
        const id = parseInt(user.id);
        
        if (isNaN(id) || id <= 0) {
            console.error('❌ Invalid user.id:', user.id);
            return 0;
        }
        
        console.log('👤 getCurrentUserId:', id, '| username:', user.username, '| user.id:', user.id, '| user.user_id:', user.user_id);
        return id;
    } catch (e) {
        console.error('❌ getCurrentUserId error:', e);
        return 0;
    }
}

// ============================================
// به‌روزرسانی تعداد اعلان‌های خوانده‌نشده
// ============================================
async function updateNotifications() {
    const userId = getCurrentUserId();
    if (!userId) {
        console.warn('⚠️ No user_id available');
        return 0;
    }

    try {
        const url = API_BASE + 'get_notifications.php?user_id=' + userId;
        console.log('📡 Fetching notifications for userId:', userId);
        
        const response = await fetch(url);
        const result = await response.json();

        if (!result.success) {
            console.error('❌ Failed to fetch notifications:', result.error);
            return 0;
        }

        const notifications = result.data || [];
        const unreadCount = notifications.filter(n => !n.is_read || n.is_read == 0).length;

        console.log('🔔 Notifications:', notifications.length, '| Unread:', unreadCount, '| userId:', userId);

        // ⭐ به‌روزرسانی بج هدر
        const badge = document.getElementById('notificationBadge');
        if (badge) {
            if (unreadCount > 0) {
                badge.textContent = unreadCount > 99 ? '99+' : String(unreadCount);
                badge.style.display = 'flex';
                console.log('✅ Header badge set to:', unreadCount);
            } else {
                badge.textContent = '0';
                badge.style.display = 'none';
            }
        }

        // ⭐ به‌روزرسانی بج سایدبار
        const sidebarBadge = document.getElementById('sidebarNotificationBadge');
        if (sidebarBadge) {
            if (unreadCount > 0) {
                sidebarBadge.textContent = unreadCount > 99 ? '99+' : String(unreadCount);
                sidebarBadge.style.display = 'inline-flex';
                console.log('✅ Sidebar badge set to:', unreadCount);
            } else {
                sidebarBadge.textContent = '0';
                sidebarBadge.style.display = 'none';
            }
        }

        localStorage.setItem('cachedNotifications', JSON.stringify(notifications));
        localStorage.setItem('unreadCount', String(unreadCount));

        return unreadCount;
    } catch (err) {
        console.error('❌ updateNotifications error:', err);
        return 0;
    }
}

// ============================================
// بارگذاری اعلان‌ها در dropdown
// ============================================
async function loadNotifications() {
    const list = document.getElementById('notificationList');
    if (!list) return;

    const userId = getCurrentUserId();
    if (!userId) return;

    try {
        const response = await fetch(API_BASE + 'get_notifications.php?user_id=' + userId);
        const result = await response.json();

        if (!result.success) {
            list.innerHTML = '<div class="no-notifications">خطا در بارگذاری اعلان‌ها</div>';
            return;
        }

        const notifications = result.data || [];

        if (notifications.length === 0) {
            list.innerHTML = '<div class="no-notifications">هیچ اعلانی وجود ندارد</div>';
            return;
        }

        const iconMap = {
            info: 'fa-info-circle',
            success: 'fa-check-circle',
            warning: 'fa-exclamation-triangle',
            danger: 'fa-exclamation-circle'
        };

        let html = '';
        notifications.slice(0, 5).forEach(n => {
            const icon = iconMap[n.type] || 'fa-info-circle';
            const unreadClass = n.is_read ? '' : 'unread';

            html += '<div class="notification-item ' + unreadClass + '" ' +
                    'onclick="handleNotificationClick(' + n.id + ', \'' + (n.link || '') + '\')">' +
                    '<div class="notification-icon ' + n.type + '">' +
                    '<i class="fas ' + icon + '"></i></div>' +
                    '<div class="notification-content">' +
                    '<div class="notification-title">' + n.title + '</div>' +
                    '<div class="notification-message">' + n.message + '</div>' +
                    '<div class="notification-time">' + n.created_at + '</div>' +
                    '</div></div>';
        });

        if (notifications.length > 5) {
            html += '<div style="text-align:center;padding:10px;color:#6c757d;font-size:13px;">' +
                    'و ' + (notifications.length - 5) + ' اعلان دیگر... <a href="notifications.html">مشاهده همه</a></div>';
        }

        list.innerHTML = html;
    } catch (err) {
        console.error('❌ loadNotifications error:', err);
        list.innerHTML = '<div class="no-notifications">خطا در ارتباط با سرور</div>';
    }
}

// ============================================
// کلیک روی اعلان
// ============================================
async function handleNotificationClick(notificationId, link) {
    const userId = getCurrentUserId();
    if (!userId) return;

    try {
        await fetch(API_BASE + 'mark_notification_read.php', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({
                notification_id: notificationId,
                user_id: userId
            })
        });
        updateNotifications();
    } catch (err) {
        console.error('❌ Error marking as read:', err);
    }

    if (link) {
        setTimeout(() => { window.location.href = link; }, 300);
    }
}

// ============================================
// ارسال اعلان به کاربران یک نقش
// ============================================
async function notifyUsersByRole(role, title, message, type, link) {
    try {
        const usersRes = await fetch(API_BASE + 'get_users.php');
        const usersData = await usersRes.json();
        
        if (!usersData || !usersData.success || !Array.isArray(usersData.data)) {
            console.warn('⚠️ Could not fetch users');
            return false;
        }

        const targetUsers = usersData.data.filter(u => {
            if (role === 'quality') return u.role === 'quality' || u.role === 'admin';
            if (role === 'cft') return u.role === 'engineering' || u.role === 'admin';
            return u.role === role;
        });

        if (targetUsers.length === 0) {
            await fetch(API_BASE + 'save_notification.php', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ user_id: null, title, message, type, link })
            });
            return true;
        }

        for (const user of targetUsers) {
            const userId = parseInt(user.id || 0);
            if (!userId) continue;

            await fetch(API_BASE + 'save_notification.php', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ user_id: userId, title, message, type, link })
            });
        }

        return true;
    } catch (e) {
        console.error('❌ notifyUsersByRole error:', e);
        return false;
    }
}

// ============================================
// صادرات به window
// ============================================
window.updateNotifications = updateNotifications;
window.loadNotifications = loadNotifications;
window.handleNotificationClick = handleNotificationClick;
window.getCurrentUserId = getCurrentUserId;
window.notifyUsersByRole = notifyUsersByRole;
window.API_BASE = API_BASE;

console.log('✅ component-utils.js loaded | API_BASE:', API_BASE);