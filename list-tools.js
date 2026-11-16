// ============================================
// list-tools.js - ابزارهای مشترک صفحه‌های لیست
// (فیلتر، مرتب‌سازی، صفحه‌بندی، خروجی اکسل و چاپ)
// ============================================
(function () {
    'use strict';

    // ----------------------------
    // امن‌سازی خروجی HTML
    // ----------------------------
    function esc(value) {
        if (value === null || value === undefined) return '';
        return String(value)
            .replace(/&/g, '&amp;')
            .replace(/</g, '&lt;')
            .replace(/>/g, '&gt;')
            .replace(/"/g, '&quot;')
            .replace(/'/g, '&#39;');
    }

    function badge(text, type) {
        return '<span class="badge badge-' + (type || 'info') + '">' + esc(text) + '</span>';
    }

    // ترجمه با کلید i18n (در صورت وجود)
    function tr(key, fallback) {
        if (window.t && typeof window.t === 'function') {
            var value = window.t(key);
            if (value !== undefined && value !== null && value !== key) return value;
        }
        return fallback !== undefined ? fallback : key;
    }

    // ----------------------------
    // خروجی CSV سازگار با Excel
    // ----------------------------
    function csvCell(value) {
        if (value === null || value === undefined) value = '';
        return '"' + String(value).replace(/"/g, '""') + '"';
    }

    function downloadCSV(filename, headers, rows) {
        var lines = [];
        lines.push(headers.map(csvCell).join(','));
        rows.forEach(function (row) {
            lines.push(row.map(csvCell).join(','));
        });

        // BOM برای نمایش صحیح فارسی در Excel
        var csv = '\uFEFF' + lines.join('\r\n');
        var blob = new Blob([csv], { type: 'text/csv;charset=utf-8;' });
        var link = document.createElement('a');
        link.href = URL.createObjectURL(blob);
        link.download = filename;
        document.body.appendChild(link);
        link.click();
        document.body.removeChild(link);
        setTimeout(function () { URL.revokeObjectURL(link.href); }, 1000);
    }

    // ----------------------------
    // موتور مشترک لیست
    // ----------------------------
    function createListPage(options) {
        options = options || {};

        var columns = options.columns || [];
        var tbody = document.getElementById(options.tbodyId || 'tableBody');
        var table = document.getElementById(options.tableId || 'dataTable');
        var countEl = options.countId ? document.getElementById(options.countId) : null;
        var pageInfoEl = document.getElementById(options.pageInfoId || 'pageInfo');
        var pageSizeEl = document.getElementById(options.pageSizeId || 'pageSize');

        var rows = [];
        var page = 1;
        var pageSize = pageSizeEl ? (parseInt(pageSizeEl.value, 10) || 25) : 25;
        var sortKey = options.defaultSort || null;
        var sortDir = options.defaultSortDir || 'desc';

        function findColumn(key) {
            for (var i = 0; i < columns.length; i++) {
                if (columns[i].key === key) return columns[i];
            }
            return null;
        }

        function sortedRows() {
            var col = sortKey ? findColumn(sortKey) : null;
            if (!col) return rows.slice();

            var getVal = col.sortValue || function (row) { return row[col.key]; };
            var out = rows.slice();

            out.sort(function (a, b) {
                var av = getVal(a);
                var bv = getVal(b);

                if (av === undefined || av === null) av = '';
                if (bv === undefined || bv === null) bv = '';

                if (typeof av === 'string') av = av.trim().toLowerCase();
                if (typeof bv === 'string') bv = bv.trim().toLowerCase();

                if (av === bv) return 0;
                var cmp = av > bv ? 1 : -1;
                return sortDir === 'asc' ? cmp : -cmp;
            });

            return out;
        }

        function updateSortIndicators() {
            if (!table) return;
            var headers = table.querySelectorAll('th[data-sort]');
            for (var i = 0; i < headers.length; i++) {
                var th = headers[i];
                th.classList.remove('sorted-asc', 'sorted-desc');
                var icon = th.querySelector('.sort-icon');
                if (icon) icon.className = 'fas fa-sort sort-icon';

                if (th.getAttribute('data-sort') === sortKey) {
                    th.classList.add(sortDir === 'asc' ? 'sorted-asc' : 'sorted-desc');
                    if (icon) {
                        icon.className = 'fas ' + (sortDir === 'asc' ? 'fa-sort-up' : 'fa-sort-down') + ' sort-icon';
                    }
                }
            }
        }

        function render() {
            if (!tbody) return;

            var data = sortedRows();
            var totalPages = Math.max(1, Math.ceil(data.length / pageSize));
            if (page > totalPages) page = totalPages;

            var start = (page - 1) * pageSize;
            var pageRows = data.slice(start, start + pageSize);

            if (!pageRows.length) {
                tbody.innerHTML = '<tr><td colspan="' + columns.length +
                    '" class="empty-row"><i class="fas fa-inbox"></i> ' + tr('no_data', 'داده‌ای برای نمایش وجود ندارد.') + '</td></tr>';
            } else {
                tbody.innerHTML = pageRows.map(function (row) {
                    var cells = columns.map(function (col) {
                        var cell = '';
                        try {
                            cell = col.render ? col.render(row) : esc(row[col.key]);
                        } catch (err) {
                            console.error('ListPage render error:', col.key, err);
                            cell = '-';
                        }
                        return '<td' + (col.cellClass ? ' class="' + col.cellClass + '"' : '') + '>' + cell + '</td>';
                    }).join('');
                    return '<tr>' + cells + '</tr>';
                }).join('');
            }

            if (countEl) countEl.textContent = tr('count_label', 'تعداد') + ': ' + data.length;
            if (pageInfoEl) pageInfoEl.textContent = tr('page_info', 'صفحه') + ' ' + page + ' / ' + totalPages;

            updateSortIndicators();
        }

        function bindSorting() {
            if (!table) return;
            var headers = table.querySelectorAll('th[data-sort]');
            for (var i = 0; i < headers.length; i++) {
                (function (th) {
                    th.classList.add('sortable');
                    th.addEventListener('click', function () {
                        var key = th.getAttribute('data-sort');
                        if (sortKey === key) {
                            sortDir = sortDir === 'asc' ? 'desc' : 'asc';
                        } else {
                            sortKey = key;
                            sortDir = 'asc';
                        }
                        page = 1;
                        render();
                    });
                })(headers[i]);
            }
        }

        bindSorting();

        return {
            setData: function (newRows) {
                rows = Array.isArray(newRows) ? newRows : [];
                page = 1;
                render();
            },
            render: render,
            getRows: function () { return rows; },
            getVisibleRows: function () { return sortedRows(); },
            prev: function () {
                if (page > 1) {
                    page--;
                    render();
                }
            },
            next: function () {
                var total = Math.max(1, Math.ceil(sortedRows().length / pageSize));
                if (page < total) {
                    page++;
                    render();
                }
            },
            setPageSize: function (value) {
                pageSize = parseInt(value, 10) || 25;
                page = 1;
                render();
            },
            exportCSV: function (filename) {
                var exportColumns = columns.filter(function (col) { return !col.noExport; });
                var headers = exportColumns.map(function (col) { return tr(col.label, col.label); });
                var body = sortedRows().map(function (row) {
                    return exportColumns.map(function (col) {
                        if (col.text) return col.text(row);
                        return row[col.key];
                    });
                });
                downloadCSV(filename, headers, body);
            },
            print: function () {
                window.print();
            }
        };
    }

    window.ListTools = {
        esc: esc,
        badge: badge,
        tr: tr,
        downloadCSV: downloadCSV
    };
    window.ListPage = createListPage;
})();
