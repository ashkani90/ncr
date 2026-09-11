// ============================================
// database.js - ارتباط با دیتابیس از طریق API
// ============================================

// تشخیص آدرس API به صورت خودکار
function getApiBaseUrl() {
    // آدرس واقعی هاست - با توجه به دامنه شما
    return 'https://ncr.page.gd/api/';
}

const API_BASE_URL = getApiBaseUrl();

// ============================================
// توابع عمومی API با مدیریت خطا
// ============================================

async function apiRequest(endpoint, method = 'GET', data = null) {
    const url = API_BASE_URL + endpoint;
    console.log('📡 API Request:', url, method, data);
    
    const options = {
        method: method,
        headers: {
            'Content-Type': 'application/json'
        }
    };
    
    if (data && (method === 'POST' || method === 'PUT')) {
        options.body = JSON.stringify(data);
    }
    
    try {
        const response = await fetch(url, options);
        
        if (!response.ok) {
            throw new Error(`HTTP error! status: ${response.status}`);
        }
        
        const result = await response.json();
        console.log('📡 API Response:', result);
        return result;
    } catch (error) {
        console.error('❌ API Error:', error);
        return { success: false, error: error.message };
    }
}

// ============================================
// تابع تست اتصال API
// ============================================

async function testApiConnection() {
    try {
        const result = await apiRequest('test_connection.php');
        console.log('🔍 API Test Result:', result);
        return result;
    } catch (error) {
        console.error('❌ API Connection Test Failed:', error);
        return { success: false, error: error.message };
    }
}

// ============================================
// توابع NCR
// ============================================

async function getAllNCRs() {
    const result = await apiRequest('get_ncrs.php');
    return result.success ? result.data : [];
}

async function getNCRByNumber(number) {
    const result = await apiRequest('get_ncr.php?number=' + encodeURIComponent(number));
    return result.success ? result.data : null;
}

async function saveNCR(ncr) {
    const result = await apiRequest('save_ncr.php', 'POST', ncr);
    return result.success;
}

async function updateNCR(number, updatedData) {
    const result = await apiRequest('update_ncr.php', 'POST', { ncr_number: number, ...updatedData });
    return result.success;
}

async function deleteNCR(number) {
    const result = await apiRequest('delete_ncr.php', 'POST', { ncr_number: number });
    return result.success;
}

// ============================================
// توابع کلیم
// ============================================

async function getAllClaims() {
    const result = await apiRequest('get_claims.php');
    return result.success ? result.data : [];
}

async function getClaimByNumber(number) {
    const result = await apiRequest('get_claim.php?number=' + encodeURIComponent(number));
    return result.success ? result.data : null;
}

async function saveClaim(claim) {
    const result = await apiRequest('save_claim.php', 'POST', claim);
    return result.success;
}

// ============================================
// توابع عدم ارسال قطعه
// ============================================

async function getAllShortages() {
    const result = await apiRequest('get_shortages.php');
    return result.success ? result.data : [];
}

async function saveShortage(shortage) {
    const result = await apiRequest('save_shortage.php', 'POST', shortage);
    return result.success;
}

// ============================================
// توابع درخواست خرید
// ============================================

async function getAllPurchaseRequests() {
    const result = await apiRequest('get_purchases.php');
    return result.success ? result.data : [];
}

async function savePurchaseRequest(request) {
    const result = await apiRequest('save_purchase.php', 'POST', request);
    return result.success;
}

// ============================================
// توابع آمار
// ============================================

async function getDashboardStats() {
    const result = await apiRequest('get_stats.php');
    return result.success ? result.data : {};
}

// ============================================
// توابع اعلان‌ها
// ============================================

async function getAllNotifications() {
    const result = await apiRequest('get_notifications.php');
    return result.success ? result.data : [];
}

async function addNotification(title, message, type, link = '') {
    const result = await apiRequest('save_notification.php', 'POST', {
        title, message, type, link
    });
    return result.success;
}

// ============================================
// توابع کاربران
// ============================================

async function getUsers() {
    const result = await apiRequest('get_users.php');
    return result.success ? result.data : [];
}

async function createUser(userData) {
    const result = await apiRequest('get_users.php', 'POST', userData);
    return result;
}

async function updateUser(id, userData) {
    const result = await apiRequest('get_users.php', 'PUT', { id, ...userData });
    return result;
}

async function deleteUser(id) {
    const result = await apiRequest('get_users.php', 'DELETE', { id });
    return result;
}

// ============================================
// توابع لاگین - نسخه نهایی با fallback
// ============================================

async function loginUser(username, password) {
    console.log('🔑 loginUser called with:', username);
    
    try {
        // اولویت اول: API
        const result = await apiRequest('login.php', 'POST', { username, password });
        console.log('🔑 Login API result:', result);
        
        if (result && result.success && result.user) {
            // ذخیره در localStorage
            localStorage.setItem('currentUser', JSON.stringify(result.user));
            return result;
        }
    } catch (error) {
        console.error('❌ Login API error:', error);
    }
    
    // Fallback: localStorage
    console.log('📦 Using localStorage fallback for login');
    return loginFromLocalStorage(username, password);
}

function loginFromLocalStorage(username, password) {
    let users = JSON.parse(localStorage.getItem('users') || '[]');
    
    // اگر کاربری وجود ندارد، از دیتابیس دریافت کن
    if (users.length === 0) {
        console.warn('⚠️ No users in localStorage. Please create users in database.');
        return { success: false, error: 'کاربری یافت نشد. لطفاً با مدیر سیستم تماس بگیرید.' };
    }
    
    const user = users.find(u => u.username === username && u.password === password);
    if (user) {
        localStorage.setItem('currentUser', JSON.stringify(user));
        return { success: true, user: user };
    }
    
    return { success: false, error: 'نام کاربری یا رمز عبور اشتباه است' };
}

// ============================================
// صادرات توابع
// ============================================

window.API_BASE_URL = API_BASE_URL;
window.getAllNCRs = getAllNCRs;
window.getNCRByNumber = getNCRByNumber;
window.saveNCR = saveNCR;
window.updateNCR = updateNCR;
window.deleteNCR = deleteNCR;
window.getAllClaims = getAllClaims;
window.getClaimByNumber = getClaimByNumber;
window.saveClaim = saveClaim;
window.getAllShortages = getAllShortages;
window.saveShortage = saveShortage;
window.getAllPurchaseRequests = getAllPurchaseRequests;
window.savePurchaseRequest = savePurchaseRequest;
window.getDashboardStats = getDashboardStats;
window.getAllNotifications = getAllNotifications;
window.addNotification = addNotification;
window.loginUser = loginUser;
window.testApiConnection = testApiConnection;
window.getUsers = getUsers;
window.createUser = createUser;
window.updateUser = updateUser;
window.deleteUser = deleteUser;

console.log('✅ database.js loaded - API URL:', API_BASE_URL);

window.API_BASE_URL = API_BASE_URL;