const bugs = JSON.parse(document.currentScript.dataset.bugs);
$(function() {
  $("#bugsGrid").dxDataGrid({
    dataSource : bugs,
    columns : [
      {
        dataField : "title",
        name : "title",
        cellTemplate : function(container, options) {
          $("<div>")
              .append($("<a>", {
                        "href" : "/ShowBug?bugId=" + options.data.id
                      }).html(options.value))
              .appendTo(container);
        }
      },
      "spell", "description"
    ],
    showBorders : true,
    filterRow : {visible : true, applyFilter : "auto"},
    searchPanel : {visible : true, width : 340, placeholder : "Search..."},
    headerFilter : {visible : true},
  });
});