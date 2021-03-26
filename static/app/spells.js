async function getJson() {
  const response = await fetch('http://localhost:8000/Spells', {
                     headers : {Accept : 'application/json'},
                   }).then((response) => response.json());

  const newHeight = window.innerHeight - (window.innerHeight * 0.15);
  $("#spellsGrid").html("");
  $("#spellsGrid").css('height', newHeight);
  $("#spellsGrid").dxDataGrid({
    dataSource : response,
    columns : [
      {dataField : "spellId", width : 140}, {
        dataField : "name",
        allowFiltering : true,
        allowSorting : true,

        cellTemplate : function(container, options) {
          $("<div>")
              .append($("<img>", {
                "src" : "/img/spells/" + options.data.spellId + ".jpg",
                "height" : "24"
              }))
              .append(
                  "<a class='spells-table-name-link' href='/ShowSpell?spellId=" +
                  options.data.id + "'>" + options.data.name + "</a>")
              .appendTo(container);
        }
      },
      "description"
    ],
    showBorders : true,
    columnsAutoWidth : true,
    showBorders : true,
    filterRow : {visible : true, applyFilter : "auto"},
    searchPanel : {visible : true, width : 340, placeholder : "Search..."},
    allowColumnResizing : true,
    showRowLines : true,
    rowAlternationEnabled : true,
    summary : {totalItems : [ {column : "spellId", summaryType : "count"} ]}
  });
}
$("#spellsGrid")
    .html(
        '<i class="fa fa-spinner fa-spin" style="float: left"></i> <p style="margin-left: 1rem">Loading Spells...</p>');
getJson();
