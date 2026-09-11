// print.js - قابلیت چاپ و خروجی

// تابع چاپ صفحه
function printPage() {
    window.print();
}

// تابع خروجی به Excel (با استفاده از SheetJS)
function exportToExcel() {
    // دریافت داده‌ها
    const ncrs = JSON.parse(localStorage.getItem('ncrs') || '[]');
    const claims = JSON.parse(localStorage.getItem('claims') || '[]');
    const shortages = JSON.parse(localStorage.getItem('shortages') || '[]');
    const purchases = JSON.parse(localStorage.getItem('purchase_requests') || '[]');
    
    if (ncrs.length === 0 && claims.length === 0 && shortages.length === 0 && purchases.length === 0) {
        alert('هیچ داده‌ای برای خروجی وجود ندارد!');
        return;
    }
    
    // ایجاد داده‌های Excel
    let excelData = [];
    
    // هدر NCR
    if (ncrs.length > 0) {
        excelData.push(['=== گزارش NCRها ===']);
        excelData.push(['شماره', 'قطعه', 'موضوع', 'تاریخ', 'وضعیت', 'اولویت', 'گزارش‌دهنده']);
        ncrs.forEach(n => {
            excelData.push([
                n.ncr_number,
                n.part_name,
                n.subject,
                n.report_date,
                n.final_status,
                n.priority,
                n.reporter_name
            ]);
        });
        excelData.push([]);
    }
    
    // هدر Claims
    if (claims.length > 0) {
        excelData.push(['=== کلیم‌ها ===']);
        excelData.push(['شماره', 'تامین‌کننده', 'قطعه', 'تاریخ', 'وضعیت', 'اولویت']);
        claims.forEach(c => {
            excelData.push([
                c.claim_number,
                c.supplier_name,
                c.part_name,
                c.claim_date,
                c.final_status,
                c.priority
            ]);
        });
        excelData.push([]);
    }
    
    // هدر Shortages
    if (shortages.length > 0) {
        excelData.push(['=== گزارش عدم ارسال قطعه ===']);
        excelData.push(['شماره', 'قطعه', 'تعداد درخواستی', 'تعداد ارسالی', 'کسری', 'وضعیت']);
        shortages.forEach(s => {
            excelData.push([
                s.shortage_number,
                s.part_name,
                s.requested_qty,
                s.sent_qty,
                s.shortage_qty,
                s.final_status
            ]);
        });
        excelData.push([]);
    }
    
    // هدر Purchase Requests
    if (purchases.length > 0) {
        excelData.push(['=== درخواست‌های خرید ===']);
        excelData.push(['شماره', 'قطعه', 'تعداد', 'تاریخ', 'وضعیت', 'فوریت']);
        purchases.forEach(p => {
            excelData.push([
                p.pr_number,
                p.part_name,
                p.quantity,
                p.request_date,
                p.final_status,
                p.urgency
            ]);
        });
    }
    
    // تبدیل به CSV
    let csvContent = excelData.map(row => row.join(',')).join('\n');
    
    // دانلود فایل
    const blob = new Blob(['\uFEFF' + csvContent], { type: 'text/csv;charset=utf-8;' });
    const link = document.createElement('a');
    link.href = URL.createObjectURL(blob);
    link.download = `NCR_Report_${new Date().toISOString().split('T')[0]}.csv`;
    link.click();
    URL.revokeObjectURL(link.href);
}

// تابع خروجی PDF (با استفاده از jsPDF)
function exportToPDF() {
    // بررسی وجود کتابخانه jsPDF
    if (typeof window.jspdf === 'undefined') {
        // بارگذاری jsPDF
        const script = document.createElement('script');
        script.src = 'https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js';
        script.onload = function() {
            generatePDF();
        };
        document.head.appendChild(script);
    } else {
        generatePDF();
    }
}

function generatePDF() {
    const { jsPDF } = window.jspdf;
    const doc = new jsPDF('p', 'mm', 'a4');
    
    const ncrs = JSON.parse(localStorage.getItem('ncrs') || '[]');
    const claims = JSON.parse(localStorage.getItem('claims') || '[]');
    
    // عنوان
    doc.setFontSize(18);
    doc.text('گزارش عدم انطباق - NCR System', 105, 20, { align: 'center' });
    doc.setFontSize(10);
    doc.text(`تاریخ: ${new Date().toLocaleDateString('fa-IR')}`, 195, 20, { align: 'right' });
    
    let yPos = 35;
    
    // NCRها
    if (ncrs.length > 0) {
        doc.setFontSize(14);
        doc.text('لیست NCRها', 20, yPos);
        yPos += 8;
        
        doc.setFontSize(9);
        const headers = ['شماره', 'قطعه', 'وضعیت', 'اولویت'];
        let xPos = 20;
        headers.forEach(h => {
            doc.text(h, xPos, yPos);
            xPos += 40;
        });
        yPos += 5;
        
        ncrs.slice(0, 10).forEach(n => {
            xPos = 20;
            doc.text(n.ncr_number, xPos, yPos);
            xPos += 40;
            doc.text(n.part_name, xPos, yPos);
            xPos += 40;
            doc.text(n.final_status, xPos, yPos);
            xPos += 40;
            doc.text(n.priority, xPos, yPos);
            yPos += 6;
            
            if (yPos > 270) {
                doc.addPage();
                yPos = 20;
            }
        });
        yPos += 10;
    }
    
    // کلیم‌ها
    if (claims.length > 0) {
        if (yPos > 250) {
            doc.addPage();
            yPos = 20;
        }
        
        doc.setFontSize(14);
        doc.text('لیست کلیم‌ها', 20, yPos);
        yPos += 8;
        
        doc.setFontSize(9);
        const headers2 = ['شماره', 'تامین‌کننده', 'قطعه', 'وضعیت'];
        let xPos2 = 20;
        headers2.forEach(h => {
            doc.text(h, xPos2, yPos);
            xPos2 += 45;
        });
        yPos += 5;
        
        claims.slice(0, 5).forEach(c => {
            xPos2 = 20;
            doc.text(c.claim_number, xPos2, yPos);
            xPos2 += 45;
            doc.text(c.supplier_name, xPos2, yPos);
            xPos2 += 45;
            doc.text(c.part_name, xPos2, yPos);
            xPos2 += 45;
            doc.text(c.final_status, xPos2, yPos);
            yPos += 6;
            
            if (yPos > 270) {
                doc.addPage();
                yPos = 20;
            }
        });
    }
    
    // ذخیره PDF
    doc.save(`NCR_Report_${new Date().toISOString().split('T')[0]}.pdf`);
}

// صادرات توابع
window.printPage = printPage;
window.exportToExcel = exportToExcel;
window.exportToPDF = exportToPDF;