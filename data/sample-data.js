// data/sample-data.js
// داده‌های نمونه برای تست سیستم NCR

const SAMPLE_DATA = {
    // ============================================
    // کاربران با سطوح دسترسی مختلف
    // ============================================
    users: [
        {
            id: 1,
            username: 'admin',
            password: 'admin123',
            full_name: 'مدیر سیستم',
            email: 'admin@ncr-system.com',
            role: 'admin',
            department: 'مدیریت',
            avatar: '👨‍💼',
            language: 'fa',
            created_at: '2026-01-01T00:00:00'
        },
        {
            id: 2,
            username: 'quality',
            password: 'quality123',
            full_name: 'علی حسینی',
            email: 'quality@ncr-system.com',
            role: 'quality',
            department: 'کنترل کیفیت',
            avatar: '🔍',
            language: 'fa',
            created_at: '2026-01-01T00:00:00'
        },
        {
            id: 3,
            username: 'production',
            password: 'prod123',
            full_name: 'احمد رضایی',
            email: 'production@ncr-system.com',
            role: 'production',
            department: 'تولید',
            avatar: '🏭',
            language: 'fa',
            created_at: '2026-01-01T00:00:00'
        },
        {
            id: 4,
            username: 'purchasing',
            password: 'purch123',
            full_name: 'محمد کریمی',
            email: 'purchasing@ncr-system.com',
            role: 'purchasing',
            department: 'خرید',
            avatar: '🛒',
            language: 'fa',
            created_at: '2026-01-01T00:00:00'
        },
        {
            id: 5,
            username: 'warehouse',
            password: 'ware123',
            full_name: 'سارا محمدی',
            email: 'warehouse@ncr-system.com',
            role: 'warehouse',
            department: 'انبار',
            avatar: '📦',
            language: 'fa',
            created_at: '2026-01-01T00:00:00'
        },
        {
            id: 6,
            username: 'engineering',
            password: 'eng123',
            full_name: 'حسین طاهری',
            email: 'engineering@ncr-system.com',
            role: 'engineering',
            department: 'مهندسی',
            avatar: '⚙️',
            language: 'fa',
            created_at: '2026-01-01T00:00:00'
        },
        {
            id: 7,
            username: 'ceo',
            password: 'ceo123',
            full_name: 'مدیرعامل',
            email: 'ceo@ncr-system.com',
            role: 'ceo',
            department: 'مدیریت',
            avatar: '👔',
            language: 'fa',
            created_at: '2026-01-01T00:00:00'
        }
    ],

    // ============================================
    // NCRهای نمونه
    // ============================================
    ncrs: [
        {
            id: 1,
            ncr_number: 'NCR-2026-0001',
            report_date: '2026-08-01',
            reporter_name: 'احمد رضایی',
            reporter_department: 'تولید',
            subject: 'خرابی بلبرینگ در دستگاه CNC',
            part_code: 'PM-1024',
            part_name: 'بلبرینگ SKF 6205',
            requested_qty: 50,
            sent_qty: 48,
            shortage_qty: 2,
            shortage_reason: 'کسری در محموله از سوی تامین‌کننده',
            unit: 'عدد',
            batch_number: 'BATCH-2026-08-01',
            documents: 'گزارش پکینگ لیست.pdf',
            location_found: 'حین تولید',
            inspector_name: 'محمد کریمی',
            inspector_department: 'کنترل کیفیت',
            description: 'بلبرینگ دچار خرابی و سایش شدید در حین تولید شده است. دمای بلبرینگ از حد مجاز بالاتر رفته و صدای غیرعادی تولید می‌کند.',
            initial_diagnosis: 'احتمالاً مشکل از مواد اولیه یا عدم روانکاری مناسب است.',
            images: 'bearing_failure.jpg',
            
            quality_status: 'approved',
            quality_check_date: '2026-08-02',
            quality_checker: 'علی حسینی',
            quality_notes: 'تایید عدم انطباق. نمونه برداری انجام شد و نتایج نشان دهنده عدم تطابق با استاندارد است.',
            root_cause: 'مواد اولیه با استاندارد مطابقت ندارد. تست سختی نشان داد که سختی بلبرینگ 15% کمتر از حد استاندارد است.',
            root_cause_category: 'Material',
            
            fmea_status: 'completed',
            fmea_date: '2026-08-03',
            fmea_engineer: 'حسین طاهری',
            fmea_risk_priority_number: 85,
            fmea_notes: 'ریسک خرابی بالا. RPN=85 نشان دهنده ریسک بحرانی است. نیاز به اقدام فوری دارد.',
            
            cft_status: 'approved',
            cft_date: '2026-08-05',
            cft_committee: 'کمیته فنی - اعضا: مدیر تولید، مدیر کیفیت، مهندس ارشد',
            disposition: 'claim',
            disposition_details: 'با توجه به ماهیت مشکل و عدم تطابق مواد، تصمیم به صدور کلیم برای تامین‌کننده گرفته شد.',
            responsible_person: 'وحید محمدی',
            due_date: '2026-08-20',
            
            rework_status: 'not_applicable',
            rework_responsible: '',
            concession_status: 'pending',
            concession_number: '',
            concession_issuer: '',
            hold_status: 'pending',
            hold_reason: '',
            hold_deadline: '',
            scrap_status: 'approved',
            scrap_responsible: 'مدیر تولید',
            claim_status: 'approved',
            claim_responsible: 'وحید محمدی',
            claim_number: 'CLM-2026-0001',
            purchase_order_status: 'pending',
            purchase_order_responsible: '',
            purchase_order_number: '',
            
            final_quality_status: 'approved',
            final_quality_date: '2026-08-10',
            final_quality_checker: 'علی حسینی',
            action_result: 'کلیم برای تامین‌کننده صادر شد و تامین‌کننده پذیرش کرد.',
            effectiveness: 'effective',
            corrective_action_needed: 'yes',
            corrective_action_number: 'CA-2026-0001',
            
            priority: 'high',
            final_status: 'in_progress',
            closure_date: '',
            closure_by: '',
            closure_notes: '',
            created_at: '2026-08-01T10:30:00',
            created_by: 'احمد رضایی',
            updated_at: '2026-08-10T14:20:00'
        },
        {
            id: 2,
            ncr_number: 'NCR-2026-0002',
            report_date: '2026-08-05',
            reporter_name: 'سارا محمدی',
            reporter_department: 'انبار',
            subject: 'عدم تطابق ابعاد قطعه پلاستیکی',
            part_code: 'PM-2056',
            part_name: 'قطعه پلاستیکی مدل A',
            requested_qty: 200,
            sent_qty: 195,
            shortage_qty: 5,
            shortage_reason: 'قطعات معیوب در بازرسی شناسایی شدند',
            unit: 'عدد',
            batch_number: 'BATCH-2026-08-05',
            documents: 'گزارش تست ابعاد.pdf',
            location_found: 'انبار',
            inspector_name: 'محمد کریمی',
            inspector_department: 'کنترل کیفیت',
            description: 'ابعاد قطعه با نقشه مطابقت ندارد. طول قطعه 2 میلی‌متر بیشتر از حد مجاز است.',
            initial_diagnosis: 'مشکل احتمالاً از قالب تزریق است.',
            images: 'dimension_error.jpg',
            
            quality_status: 'approved',
            quality_check_date: '2026-08-06',
            quality_checker: 'علی حسینی',
            quality_notes: 'عدم انطباق تایید شد. 5 قطعه از 200 قطعه دارای ابعاد نامناسب هستند.',
            root_cause: 'قالب تزریق فرسوده شده و نیاز به تعمیر دارد.',
            root_cause_category: 'Method',
            
            fmea_status: 'pending',
            fmea_date: '',
            fmea_engineer: '',
            fmea_risk_priority_number: 0,
            fmea_notes: '',
            
            cft_status: 'pending',
            cft_date: '',
            cft_committee: '',
            disposition: '',
            disposition_details: '',
            responsible_person: '',
            due_date: '',
            
            rework_status: 'pending',
            rework_responsible: 'مدیر تولید',
            concession_status: 'pending',
            concession_number: '',
            concession_issuer: '',
            hold_status: 'pending',
            hold_reason: '',
            hold_deadline: '',
            scrap_status: 'pending',
            scrap_responsible: '',
            claim_status: 'pending',
            claim_responsible: '',
            claim_number: '',
            purchase_order_status: 'pending',
            purchase_order_responsible: '',
            purchase_order_number: '',
            
            final_quality_status: 'pending',
            final_quality_date: '',
            final_quality_checker: '',
            action_result: '',
            effectiveness: '',
            corrective_action_needed: 'pending',
            corrective_action_number: '',
            
            priority: 'medium',
            final_status: 'open',
            closure_date: '',
            closure_by: '',
            closure_notes: '',
            created_at: '2026-08-05T14:15:00',
            created_by: 'سارا محمدی',
            updated_at: '2026-08-06T09:00:00'
        },
        {
            id: 3,
            ncr_number: 'NCR-2026-0003',
            report_date: '2026-08-10',
            reporter_name: 'رضا احمدی',
            reporter_department: 'کنترل کیفیت',
            subject: 'کیفیت رنگ نامناسب در قطعات فلزی',
            part_code: 'PM-3089',
            part_name: 'قطعه فلزی رنگ شده',
            requested_qty: 150,
            sent_qty: 145,
            shortage_qty: 5,
            shortage_reason: 'رنگ اشتباه در 5 قطعه',
            unit: 'عدد',
            batch_number: 'BATCH-2026-08-10',
            documents: 'گزارش کنترل رنگ.pdf',
            location_found: 'خروجی',
            inspector_name: 'رضا احمدی',
            inspector_department: 'کنترل کیفیت',
            description: 'رنگ قطعه با استاندارد RAL 9010 مطابقت ندارد. رنگ قطعات به سمت زردی متمایل است.',
            initial_diagnosis: 'مشکل در فرآیند رنگ‌کاری یا مواد اولیه رنگ.',
            images: 'color_mismatch.jpg',
            
            quality_status: 'approved',
            quality_check_date: '2026-08-11',
            quality_checker: 'علی حسینی',
            quality_notes: 'عدم انطباق تایید شد. نمونه‌ها به آزمایشگاه ارسال شد.',
            root_cause: 'مواد رنگ نامرغوب و عدم کنترل دما در فرآیند پخت.',
            root_cause_category: 'Material',
            
            fmea_status: 'pending',
            fmea_date: '',
            fmea_engineer: '',
            fmea_risk_priority_number: 0,
            fmea_notes: '',
            
            cft_status: 'pending',
            cft_date: '',
            cft_committee: '',
            disposition: '',
            disposition_details: '',
            responsible_person: '',
            due_date: '',
            
            rework_status: 'pending',
            rework_responsible: '',
            concession_status: 'pending',
            concession_number: '',
            concession_issuer: '',
            hold_status: 'pending',
            hold_reason: '',
            hold_deadline: '',
            scrap_status: 'pending',
            scrap_responsible: '',
            claim_status: 'pending',
            claim_responsible: '',
            claim_number: '',
            purchase_order_status: 'pending',
            purchase_order_responsible: '',
            purchase_order_number: '',
            
            final_quality_status: 'pending',
            final_quality_date: '',
            final_quality_checker: '',
            action_result: '',
            effectiveness: '',
            corrective_action_needed: 'pending',
            corrective_action_number: '',
            
            priority: 'high',
            final_status: 'open',
            closure_date: '',
            closure_by: '',
            closure_notes: '',
            created_at: '2026-08-10T09:45:00',
            created_by: 'رضا احمدی',
            updated_at: '2026-08-11T11:00:00'
        },
        {
            id: 4,
            ncr_number: 'NCR-2026-0004',
            report_date: '2026-08-12',
            reporter_name: 'محمد حسینی',
            reporter_department: 'مشتری',
            subject: 'شکایت مشتری از کیفیت بسته‌بندی',
            part_code: 'PM-4100',
            part_name: 'محصول نهایی بسته‌بندی شده',
            requested_qty: 500,
            sent_qty: 490,
            shortage_qty: 10,
            shortage_reason: 'بسته‌بندی آسیب دیده',
            unit: 'عدد',
            batch_number: 'BATCH-2026-08-12',
            documents: 'شکایت مشتری.pdf',
            location_found: 'مشتری',
            inspector_name: 'محمد حسینی',
            inspector_department: 'خدمات پس از فروش',
            description: 'مشتری از کیفیت بسته‌بندی شکایت کرده است. بسته‌ها در حین حمل آسیب دیده‌اند.',
            initial_diagnosis: 'مشکل در مواد بسته‌بندی یا روش حمل و نقل.',
            images: 'packaging_damage.jpg',
            
            quality_status: 'approved',
            quality_check_date: '2026-08-13',
            quality_checker: 'علی حسینی',
            quality_notes: 'شکایت مشتری تایید شد. نیاز به بررسی زنجیره تامین.',
            root_cause: 'استفاده از مواد بسته‌بندی با کیفیت پایین و عدم رعایت استانداردهای حمل.',
            root_cause_category: 'Material',
            
            fmea_status: 'pending',
            fmea_date: '',
            fmea_engineer: '',
            fmea_risk_priority_number: 0,
            fmea_notes: '',
            
            cft_status: 'pending',
            cft_date: '',
            cft_committee: '',
            disposition: '',
            disposition_details: '',
            responsible_person: '',
            due_date: '',
            
            rework_status: 'pending',
            rework_responsible: '',
            concession_status: 'pending',
            concession_number: '',
            concession_issuer: '',
            hold_status: 'pending',
            hold_reason: '',
            hold_deadline: '',
            scrap_status: 'pending',
            scrap_responsible: '',
            claim_status: 'pending',
            claim_responsible: '',
            claim_number: '',
            purchase_order_status: 'pending',
            purchase_order_responsible: '',
            purchase_order_number: '',
            
            final_quality_status: 'pending',
            final_quality_date: '',
            final_quality_checker: '',
            action_result: '',
            effectiveness: '',
            corrective_action_needed: 'pending',
            corrective_action_number: '',
            
            priority: 'high',
            final_status: 'open',
            closure_date: '',
            closure_by: '',
            closure_notes: '',
            created_at: '2026-08-12T16:20:00',
            created_by: 'محمد حسینی',
            updated_at: '2026-08-13T10:30:00'
        },
        {
            id: 5,
            ncr_number: 'NCR-2026-0005',
            report_date: '2026-08-15',
            reporter_name: 'زهرا کریمی',
            reporter_department: 'کنترل کیفیت',
            subject: 'عدم تطابق وزن قطعه',
            part_code: 'PM-5120',
            part_name: 'قطعه ریخته‌گری آلومینیوم',
            requested_qty: 100,
            sent_qty: 98,
            shortage_qty: 2,
            shortage_reason: 'وزن قطعه کمتر از حد استاندارد',
            unit: 'کیلوگرم',
            batch_number: 'BATCH-2026-08-15',
            documents: 'گزارش وزن.pdf',
            location_found: 'ورودی',
            inspector_name: 'زهرا کریمی',
            inspector_department: 'کنترل کیفیت',
            description: 'وزن قطعات ریخته‌گری 5% کمتر از حد استاندارد است.',
            initial_diagnosis: 'احتمالاً مشکل در فرآیند ریخته‌گری یا مواد اولیه.',
            images: 'weight_test.jpg',
            
            quality_status: 'pending',
            quality_check_date: '',
            quality_checker: '',
            quality_notes: '',
            root_cause: '',
            root_cause_category: '',
            
            fmea_status: 'pending',
            fmea_date: '',
            fmea_engineer: '',
            fmea_risk_priority_number: 0,
            fmea_notes: '',
            
            cft_status: 'pending',
            cft_date: '',
            cft_committee: '',
            disposition: '',
            disposition_details: '',
            responsible_person: '',
            due_date: '',
            
            rework_status: 'pending',
            rework_responsible: '',
            concession_status: 'pending',
            concession_number: '',
            concession_issuer: '',
            hold_status: 'pending',
            hold_reason: '',
            hold_deadline: '',
            scrap_status: 'pending',
            scrap_responsible: '',
            claim_status: 'pending',
            claim_responsible: '',
            claim_number: '',
            purchase_order_status: 'pending',
            purchase_order_responsible: '',
            purchase_order_number: '',
            
            final_quality_status: 'pending',
            final_quality_date: '',
            final_quality_checker: '',
            action_result: '',
            effectiveness: '',
            corrective_action_needed: 'pending',
            corrective_action_number: '',
            
            priority: 'medium',
            final_status: 'open',
            closure_date: '',
            closure_by: '',
            closure_notes: '',
            created_at: '2026-08-15T08:00:00',
            created_by: 'زهرا کریمی',
            updated_at: '2026-08-15T08:00:00'
        }
    ],

    // ============================================
    // کلیم‌های نمونه
    // ============================================
    claims: [
        {
            id: 1,
            claim_number: 'CLM-2026-0001',
            claim_date: '2026-08-06',
            ncr_number: 'NCR-2026-0001',
            supplier_name: 'تامین‌کننده قطعات صنعتی البرز',
            supplier_contact: '09123456789',
            order_date: '2026-07-25',
            invoice_number: 'INV-2026-0456',
            invoice_image: 'invoice_0456.jpg',
            part_code: 'PM-1024',
            part_name: 'بلبرینگ SKF 6205',
            quantity: 48,
            unit: 'عدد',
            return_reason: 'خرابی',
            return_reason_description: 'خرابی بلبرینگ در حین تولید با سایش شدید',
            part_image: 'bearing_failure.jpg',
            request_type: 'تعویض با کالای دیگر',
            claim_quantity: 2,
            priority: 'high',
            claim_stage: 3,
            
            ceo_status: 'approved',
            ceo_approved_date: '2026-08-07',
            ceo_notes: 'تایید کلیم صادر شده. به تامین‌کننده ارسال شود.',
            
            supplier_status: 'approved',
            supplier_response_date: '2026-08-09',
            supplier_approved: true,
            supplier_replacement_date: '2026-08-20',
            supplier_cost_amount: 0,
            supplier_notes: 'قطعه جایگزین در تاریخ ۲۰ مرداد ارسال می‌شود. هزینه حمل بر عهده ما.',
            corrective_action_number: 'CA-2026-0001',
            action_result: 'تامین‌کننده پذیرش کرد و قطعه جایگزین ارسال خواهد شد.',
            
            warehouse_status: 'pending',
            replacement_received_date: '',
            replacement_quantity: 0,
            warehouse_notes: '',
            
            final_status: 'in_progress',
            created_at: '2026-08-06T11:20:00',
            updated_at: '2026-08-09T13:00:00'
        },
        {
            id: 2,
            claim_number: 'CLM-2026-0002',
            claim_date: '2026-08-11',
            ncr_number: 'NCR-2026-0002',
            supplier_name: 'تامین‌کننده قطعات پلاستیک پارس',
            supplier_contact: '09123456788',
            order_date: '2026-07-30',
            invoice_number: 'INV-2026-0520',
            invoice_image: 'invoice_0520.jpg',
            part_code: 'PM-2056',
            part_name: 'قطعه پلاستیکی مدل A',
            quantity: 195,
            unit: 'عدد',
            return_reason: 'عدم تطابق ابعاد',
            return_reason_description: 'ابعاد قطعه با نقشه مطابقت ندارد',
            part_image: 'dimension_error.jpg',
            request_type: 'مرجوعی کامل و برگشت هزینه',
            claim_quantity: 5,
            priority: 'medium',
            claim_stage: 2,
            
            ceo_status: 'pending',
            ceo_approved_date: '',
            ceo_notes: '',
            
            supplier_status: 'pending',
            supplier_response_date: '',
            supplier_approved: null,
            supplier_replacement_date: '',
            supplier_cost_amount: 0,
            supplier_notes: '',
            corrective_action_number: '',
            action_result: '',
            
            warehouse_status: 'pending',
            replacement_received_date: '',
            replacement_quantity: 0,
            warehouse_notes: '',
            
            final_status: 'open',
            created_at: '2026-08-11T09:30:00',
            updated_at: '2026-08-11T09:30:00'
        }
    ],

    // ============================================
    // گزارش‌های عدم ارسال قطعه
    // ============================================
    shortages: [
        {
            id: 1,
            shortage_number: 'SH-2026-0001',
            report_date: '2026-08-03',
            reporter_name: 'محمد رضایی',
            reporter_department: 'انبار',
            subject: 'عدم دریافت 2 عدد بلبرینگ',
            part_code: 'PM-1024',
            part_name: 'بلبرینگ SKF 6205',
            part_image: 'bearing.jpg',
            batch_number: 'BATCH-2026-08-01',
            requested_qty: 50,
            sent_qty: 48,
            shortage_qty: 2,
            unit: 'عدد',
            documents: 'packing_list_0801.pdf',
            description: 'در محموله دریافتی 2 عدد بلبرینگ وجود نداشت. پکینگ لیست 50 عدد را نشان می‌دهد اما 48 عدد دریافت شد.',
            
            ceo_status: 'approved',
            ceo_approved_date: '2026-08-04',
            ceo_notes: 'تایید عدم ارسال قطعه. به تامین‌کننده اطلاع داده شود.',
            
            supplier_status: 'approved',
            supplier_response_date: '2026-08-05',
            supplier_approved: true,
            supplier_replacement_date: '2026-08-15',
            supplier_cost_amount: 0,
            supplier_notes: 'قطعه جایگزین ارسال می‌شود. عذرخواهی می‌کنیم.',
            corrective_action_number: 'CA-2026-0001',
            action_result: 'تامین‌کننده پذیرش کرد و قطعه جایگزین ارسال خواهد شد.',
            
            warehouse_status: 'pending',
            replacement_received_date: '',
            replacement_quantity: 0,
            warehouse_notes: '',
            
            final_status: 'in_progress',
            created_at: '2026-08-03T13:45:00',
            updated_at: '2026-08-05T10:15:00'
        },
        {
            id: 2,
            shortage_number: 'SH-2026-0002',
            report_date: '2026-08-08',
            reporter_name: 'سارا محمدی',
            reporter_department: 'انبار',
            subject: 'کمبود قطعات پلاستیکی',
            part_code: 'PM-2056',
            part_name: 'قطعه پلاستیکی مدل A',
            part_image: 'plastic_part.jpg',
            batch_number: 'BATCH-2026-08-05',
            requested_qty: 200,
            sent_qty: 195,
            shortage_qty: 5,
            unit: 'عدد',
            documents: 'packing_list_0805.pdf',
            description: '5 عدد قطعه پلاستیکی در محموله وجود نداشت.',
            
            ceo_status: 'pending',
            ceo_approved_date: '',
            ceo_notes: '',
            
            supplier_status: 'pending',
            supplier_response_date: '',
            supplier_approved: null,
            supplier_replacement_date: '',
            supplier_cost_amount: 0,
            supplier_notes: '',
            corrective_action_number: '',
            action_result: '',
            
            warehouse_status: 'pending',
            replacement_received_date: '',
            replacement_quantity: 0,
            warehouse_notes: '',
            
            final_status: 'open',
            created_at: '2026-08-08T11:20:00',
            updated_at: '2026-08-08T11:20:00'
        }
    ],

    // ============================================
    // درخواست‌های خرید
    // ============================================
    purchase_requests: [
        {
            id: 1,
            pr_number: 'PR-2026-0001',
            request_date: '2026-08-08',
            requester_name: 'علی محمدی',
            requester_department: 'تولید',
            part_code: 'PM-2056',
            part_name: 'قطعه پلاستیکی مدل A',
            quantity: 200,
            unit: 'عدد',
            urgency: 'high',
            required_date: '2026-08-30',
            budget_estimate: 15000000,
            reason: 'کمبود قطعه به دلیل عدم انطباق و ضایعات',
            ncr_number: 'NCR-2026-0002',
            claim_number: '',
            documents: '',
            
            supervisor_status: 'approved',
            supervisor_approved_date: '2026-08-09',
            supervisor_notes: 'تایید می‌شود. نیاز فوری به قطعه داریم.',
            
            finance_status: 'approved',
            finance_approved_date: '2026-08-10',
            finance_notes: 'بودجه تایید شد. مبلغ ۱۵ میلیون تومان تخصیص داده شد.',
            
            procurement_status: 'in_progress',
            procurement_notes: 'در حال بررسی تامین‌کننده‌های مختلف',
            po_number: 'PO-2026-0045',
            supplier_name: 'تامین‌کننده قطعات پلاستیک پارس',
            order_date: '2026-08-12',
            
            final_status: 'in_progress',
            created_at: '2026-08-08T08:30:00',
            updated_at: '2026-08-12T09:00:00'
        },
        {
            id: 2,
            pr_number: 'PR-2026-0002',
            request_date: '2026-08-13',
            requester_name: 'احمد رضایی',
            requester_department: 'تولید',
            part_code: 'PM-1024',
            part_name: 'بلبرینگ SKF 6205',
            quantity: 50,
            unit: 'عدد',
            urgency: 'critical',
            required_date: '2026-08-22',
            budget_estimate: 25000000,
            reason: 'جایگزینی قطعات معیوب و افزایش تولید',
            ncr_number: 'NCR-2026-0001',
            claim_number: 'CLM-2026-0001',
            documents: '',
            
            supervisor_status: 'approved',
            supervisor_approved_date: '2026-08-14',
            supervisor_notes: 'تایید فوری. خط تولید متوقف می‌شود.',
            
            finance_status: 'pending',
            finance_approved_date: '',
            finance_notes: '',
            
            procurement_status: 'pending',
            procurement_notes: '',
            po_number: '',
            supplier_name: '',
            order_date: '',
            
            final_status: 'pending',
            created_at: '2026-08-13T14:00:00',
            updated_at: '2026-08-14T09:30:00'
        }
    ],

    // ============================================
    // اعلان‌ها
    // ============================================
    notifications: [
        {
            id: 1,
            user_id: 1,
            title: 'NCR جدید ثبت شد',
            message: 'NCR-2026-0001 توسط احمد رضایی ثبت شد',
            type: 'info',
            icon: 'fa-info-circle',
            link: 'ncr-detail.html?number=NCR-2026-0001',
            is_read: false,
            created_at: '۱۴۰۵/۰۵/۱۰ ۱۰:۳۰'
        },
        {
            id: 2,
            user_id: 2,
            title: 'بررسی کیفیت مورد نیاز',
            message: 'NCR-2026-0002 نیاز به بررسی کیفیت دارد',
            type: 'warning',
            icon: 'fa-exclamation-triangle',
            link: 'ncr-detail.html?number=NCR-2026-0002',
            is_read: false,
            created_at: '۱۴۰۵/۰۵/۱۴ ۱۴:۱۵'
        },
        {
            id: 3,
            user_id: 3,
            title: 'کلیم صادر شد',
            message: 'کلیم CLM-2026-0001 برای قطعه بلبرینگ صادر شد',
            type: 'success',
            icon: 'fa-check-circle',
            link: 'claim-form.html?number=CLM-2026-0001',
            is_read: false,
            created_at: '۱۴۰۵/۰۵/۱۵ ۱۱:۲۰'
        },
        {
            id: 4,
            user_id: 1,
            title: 'گزارش عدم ارسال قطعه',
            message: 'گزارش SH-2026-0001 برای قطعه بلبرینگ ثبت شد',
            type: 'danger',
            icon: 'fa-exclamation-circle',
            link: 'shortage-form.html?number=SH-2026-0001',
            is_read: false,
            created_at: '۱۴۰۵/۰۵/۱۲ ۱۳:۴۵'
        },
        {
            id: 5,
            user_id: 4,
            title: 'درخواست خرید جدید',
            message: 'PR-2026-0001 برای قطعه پلاستیکی ثبت شد',
            type: 'info',
            icon: 'fa-shopping-cart',
            link: 'purchase-request.html?number=PR-2026-0001',
            is_read: true,
            created_at: '۱۴۰۵/۰۵/۱۷ ۰۸:۳۰'
        },
        {
            id: 6,
            user_id: 6,
            title: 'FMEA نیاز به بررسی دارد',
            message: 'NCR-2026-0003 نیاز به تحلیل FMEA دارد',
            type: 'warning',
            icon: 'fa-chart-line',
            link: 'ncr-detail.html?number=NCR-2026-0003',
            is_read: false,
            created_at: '۱۴۰۵/۰۵/۱۹ ۰۹:۴۵'
        },
        {
            id: 7,
            user_id: 7,
            title: 'تایید کلیم مورد نیاز',
            message: 'کلیم CLM-2026-0002 نیاز به تایید مدیرعامل دارد',
            type: 'info',
            icon: 'fa-user-tie',
            link: 'claim-form.html?number=CLM-2026-0002',
            is_read: false,
            created_at: '۱۴۰۵/۰۵/۲۰ ۰۹:۳۰'
        }
    ]
};

// ============================================
// تابع بارگذاری داده‌های نمونه
// ============================================
function loadSampleData() {
    const tables = {
        users: SAMPLE_DATA.users,
        ncrs: SAMPLE_DATA.ncrs,
        claims: SAMPLE_DATA.claims,
        shortages: SAMPLE_DATA.shortages,
        purchase_requests: SAMPLE_DATA.purchase_requests,
        notifications: SAMPLE_DATA.notifications
    };

    let loaded = false;
    Object.keys(tables).forEach(key => {
        if (!localStorage.getItem(key)) {
            localStorage.setItem(key, JSON.stringify(tables[key]));
            loaded = true;
        }
    });

    if (loaded) {
        console.log('✅ داده‌های نمونه با موفقیت بارگذاری شدند.');
    } else {
        console.log('ℹ️ داده‌های نمونه قبلاً وجود دارند.');
    }
}

// ============================================
// تابع بازنشانی داده‌ها (برای تست)
// ============================================
function resetSampleData() {
    if (confirm('⚠️ آیا مطمئن هستید؟ تمام داده‌های فعلی پاک خواهند شد!')) {
        Object.keys(SAMPLE_DATA).forEach(key => {
            localStorage.setItem(key, JSON.stringify(SAMPLE_DATA[key]));
        });
        alert('✅ داده‌ها بازنشانی شدند.');
        location.reload();
    }
}

// ============================================
// بارگذاری خودکار
// ============================================
if (typeof document !== 'undefined') {
    document.addEventListener('DOMContentLoaded', function() {
        loadSampleData();
    });
}

// ============================================
// صادرات برای استفاده در سایر ماژول‌ها
// ============================================
if (typeof module !== 'undefined' && module.exports) {
    module.exports = {
        SAMPLE_DATA,
        loadSampleData,
        resetSampleData
    };
}

// صادرات به window برای استفاده در مرورگر
if (typeof window !== 'undefined') {
    window.SAMPLE_DATA = SAMPLE_DATA;
    window.loadSampleData = loadSampleData;
    window.resetSampleData = resetSampleData;
}