(function(global, factory) {
    //引出环境设置，该插件能够支持三大模块化标准
    typeof exports === "object" && typeof module !== "undefined" ? module.exports = factory() : 
    typeof define === "function" && define.amd ? define(factory) : 
    (global.Table = factory());
})(this, function() {
    'use strict';
    return function(obj) {
        console.log(123);
        if(!isObject(obj)) {
            throw new Error("数据类型错误");
        }
        ajax(obj, obj.ajaxData.queryParams);
    }

    /**
     * 判断是否为对象
     * @param obj
     */
    function isObject(obj) {
        return typeof obj === "object" && obj !== "null";
    }

    /**
     * 对象合并
     * @param o
     * @param n
     * @param override
     */
    function extend(o, n, override) {
        for(var key in n) {
            if(n.hasOwnProperty(key) && (!o.hasOwnProperty(key) || override)) {
                o[key] = n[key];
            }
        }
        return o;
    }

    /**
     * ajax请求
     * @param o
     * @param a
     */
    function ajax(o, a) {
        $.ajax({
            url: o.ajaxData.url,
            type: o.ajaxData.method || 'post',
            dataType: 'JSON',
            data: a,
            success: function(res) {
                if(res.code == 201) {
                    o.data = res.data;
                    var page = o.paginOpt;
                    var curPage = a.pageNum;
                    drawTable(o);
                    if(o.pagination) {
                        initPage(o, curPage, res.count, page);
                    }
                }
            },
            error: function(res) {
                console.log(res.message)
            }
        });
    }

    /**
     * 画表格
     * @param obj
     */
    function drawTable(obj) {
        var el = obj.el,
            col = obj.col,
            data = obj.data,
            tableParent = document.querySelector(el),
            table = document.createElement("div"),
            thead = document.createElement("div"),
            tbody = document.createElement("div"),
            str = '';
        console.log(1);
        tableParent.innerHTML = '';
        table.className = "table";
        thead.className = "table-header";
        tbody.className = "table-row-group";
        tableParent.appendChild(table);
        for(var key in col) {
            str += "<div class='table-cell'>" + col[key].name + "</div>";
        };
        thead.innerHTML = str;
        table.appendChild(thead);
        data.forEach(function(doc, index, data) {
            var tr = document.createElement("div"),
                std = '';
            tr.className = "table-row";
            if(index % 2 == 1 && obj.stripe) {
                tr.className += " single";
            }
            col.forEach(function(contend) {
                if (contend.link) {
                    std += "<div class='table-cell'><a href=" + contend.icon + ">" + doc[contend.value] + "</a></div>";
                } else {
                    std += "<div class='table-cell'>" + doc[contend.value] + "</div>";
                }
            });
            tr.innerHTML = std;
            tbody.appendChild(tr);
            table.appendChild(tbody);
        })
        var headList = thead.getElementsByTagName("div"),
            trList = document.getElementsByClassName("table-row");
        sortBycol(obj, headList, trList, tbody);
    }

    /**
     * 根据表头排序（静态）
     * @param obj
     * @param headList 表头数组
     * @param trList 可排序的表头数组
     * @param tbody 
     */
    function sortBycol(obj, headList, trList, tbody) {
        var sortArray = new Array,
            newNode,
            flag,
            sort = obj.sort;
        for(var i = 0; i < sort.length; i++ ) {
            headList[sort[i]].index = sort[i];
            flag = false;
            headList[sort[i]].onclick = function() {
                newNode = '';
                for(var j = 0; j < trList.length; j++) {
                    sortArray[j] = new Array();
                    sortArray[j][0] = trList[j].getElementsByTagName("div")[this.index].innerText;
                    sortArray[j][1] = j;
                }
                if(flag) {
                    sortArray.reverse();
                } else {
                    if(!isNaN(sortArray[0][0])) {
                        sortArray.sort(sortNumber);
                    } else {
                        sortArray.sort();
                    }
                    flag = true;
                }
                for(var x = 0; x < trList.length; x++) {
                    if(x % 2 == 1 && obj.stripe) {
                        newNode += "<div class='table-row single'>" + trList[sortArray[x][1]].innerHTML + "</div>";
                    } else {
                        newNode += "<div class='table-row'>" + trList[sortArray[x][1]].innerHTML + "</div>";
                    }
                }
                tbody.innerHTML = newNode;
            }
        }
    }

    /**
     * 排序
     * @param b
     * @param a
     */
    function sortNumber(b, a) {
        b = parseInt(b);
        a = parseInt(a);
        if(a > b) {
            return 1;
        } else if (a < b) {
            return -1;
        } else {
            return 0;
        }
    }

    /**
     * 初始化数据处理
     * @param listCount 列表总量
     * @param currentPage 当前页
     */
    function initPage(obj, currentPage, listCount, page) {
        if(listCount < 0) {
            listCount = 0;
        }
        if(currentPage <= 0) {
            currentPage = 1;
        }
        setPageListCount(obj, listCount, currentPage, page);
    }

    /**
     * 初始化分页界面
     * @param listCount 列表总量
     */
    function initWithUl(listCount, currentPage, page) {
        var pageCount = 1;
        if(listCount >= 0) {
            var pageCount = listCount % page.pagelistcount > 0 ? parseInt(listCount / page.pagelistcount) + 1 : parseInt(listCount / page.pagelistcount);
        }
        var appendStr = getPageListModel(pageCount, currentPage, page);
        $("#" + page.id).html(appendStr);
    }

    /**
     * 设置列表总量和当前页码
     * @param listCount 列表总量
     * @param currentPage 当前页码
     */
    function setPageListCount(obj, listCount, currentPage, page) {
        listCount = parseInt(listCount);
        currentPage = parseInt(currentPage);
        initWithUl(listCount, currentPage, page);
        initPageEvent(obj, page);
    }

    /**
     * 页码点击请求数据
     * @param obj 
     * @param page
     */
    function initPageEvent(obj, page) {
        $("#" + page.id + ">li[class='pageItem']").on("click", function() {
            var options = {};
            options.pageNum = $(this).attr("page-data");
            options.pageSize = page.pagelistcount;
            ajax(obj, options, page);
        });
    }
    
    /**
     * 描绘分页
     * @param pageCount 总页数
     * @param currentPage 当前页码
     */
    function getPageListModel(pageCount, currentPage, page) {
        var prePage = currentPage - 1;
        var nextPage = currentPage + 1;
        var prePageClass = "pageItem";
        var nextPageClass = "pageItem";
        if(prePage <= 0) {
            prePageClass = "pageItemDisable";
        }
        if(nextPage > pageCount) {
            nextPageClass = "pageItemDisable";
        }
        var appendStr = "";
        appendStr += "<li class='" + prePageClass + "' page-data='1' page-rel='firstpage'>首页</li>";
        appendStr += "<li class='" + prePageClass + "' page-data='" + prePage + "' page-rel='prepage'>&lt;</li>";
        var miniPageNumber = 1;
        if(currentPage - parseInt(page.maxshowpageitem / 2) > 0 && currentPage + parseInt(page.maxshowpageitem / 2) <= pageCount) {
            miniPageNumber = currentPage - parseInt(page.maxshowpageitem / 2);
        } else if(currentPage - parseInt(page.maxshowpageitem / 2) > 0 && currentPage + parseInt(page.maxshowpageitem / 2) > pageCount) {
            miniPageNumber = pageCount - page.maxshowpageitem + 1;
            if(miniPageNumber <= 0) {
                miniPageNumber = 1;
            }
        }
        var showPageNum = parseInt(page.maxshowpageitem);
        if(pageCount < showPageNum) {
            showPageNum = pageCount;
        }
        for(var i = 0; i < showPageNum; i++) {
            var pageNumber = miniPageNumber++;
            var itemPageClass = "pageItem";
            if(pageNumber == currentPage) {
                itemPageClass = "pageItemActive";
            }

            appendStr += "<li class='" + itemPageClass + "' page-data='" + pageNumber + "' page-rel='itempage'>" + pageNumber + "</li>";
        }
        appendStr += "<li class='" + nextPageClass + "' page-data='" + nextPage + "' page-rel='nextpage'>&gt;</li>";
        appendStr += "<li class='" + nextPageClass + "' page-data='" + pageCount + "' page-rel='lastpage'>尾页</li>";
		appendStr += "<li class='total'>共" + pageCount + "页 </li>";
		return appendStr;
	}
});