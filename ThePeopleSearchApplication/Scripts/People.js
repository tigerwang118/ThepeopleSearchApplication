var searchTimer;
$(function () {
    document.getElementById("searchTextBox").focus();
    //$("input[type='button']").button();
    LoadPeople();
});
function LoadPeople()
{
    $('.k-loading-mask').show();
$.getJSON(
      "/Home/GetPeople",
      null,
      function(data)
      {
          var tbody = document.getElementById("peopleTable").getElementsByTagName("tbody")[0];
          PopulatePeopleTable(data, tbody);
          //$(tbody).find("input[type='button']").button();
          var searchTextBox = document.getElementById("searchTextBox");
          var handler = function()
          {
              SearchForPeopleDelayed(this.value);
          };

          searchTextBox.oninput = handler;
          searchTextBox.onkeyup = handler;

          var searchText = document.getElementById("searchTextBox").value;
          if (searchText.length > 0)
          {
              SearchForPeople(searchText);
          }
          $('.k-loading-mask').fadeOut(1000);
      }
  )
  .fail(function()
  {
      $('.k-loading-mask').fadeOut(1000);
      alert("Unable to load people.");
  });
}
function SearchForPeopleDelayed(text)
{
    if (searchTimer)
    {
        clearTimeout(searchTimer);
    }

    searchTimer = setTimeout(function() { SearchForPeople(text); }, 200);
}

function SearchForPeople(text)
{
    var counter = 0;
    text = text.toUpperCase();
    $("#peopleTable").find("tbody > tr").each(function()
    {
        if ($(this).children("td[id^='firstName_']").text().toUpperCase().indexOf(text) >= 0 ||
            $(this).children("td[id^='lastName_']").text().toUpperCase().indexOf(text) >= 0)
        {
            this.className = ++counter % 2 === 0 ? "AlternateRow" : "";
            this.style.display = "";
        }
        else
        {
            this.style.display = "none";
        }
    });
}
function PopulatePeopleTable(data, tbody) {
    $(tbody).empty();
    for (var i = 0; i < data.length; i++) {
        var tr = document.createElement("tr");
        tr.className = i % 2 === 0 ? "" : "k-alt";
        var firstNameCell = document.createElement("td");
        firstNameCell.id = "firstName_" + data[i].Id;
        firstNameCell.className = "cln100";
        firstNameCell.appendChild(document.createTextNode(data[i].FirstName));
        tr.appendChild(firstNameCell);

        var lastNameCell = document.createElement("td");
        lastNameCell.id = "lastName_" + data[i].Id;
        lastNameCell.className = "cln100";
        lastNameCell.appendChild(document.createTextNode(data[i].LastName));
        tr.appendChild(lastNameCell);

        var addressCell = document.createElement("td");
        addressCell.id = "address_" + data[i].Id;
        addressCell.className = "cln200";
        addressCell.appendChild(document.createTextNode(data[i].Address));
        tr.appendChild(addressCell);

        var ageCell = document.createElement("td");
        ageCell.id = "age_" + data[i].Id;
        ageCell.className = "cln100";
        ageCell.appendChild(document.createTextNode(data[i].Age));
        tr.appendChild(ageCell);
      
        var interestsCell = document.createElement("td");
        interestsCell.id = "interests_" + data[i].Id;
        interestsCell.className = "cln200";
        interestsCell.appendChild(document.createTextNode(data[i].Interests));
        tr.appendChild(interestsCell);

        var imageCell = document.createElement("td");
        imageCell.className = "patientImage";
        var patientImage = imageCell.appendChild(document.createElement("img"));
        patientImage.src = data[i].ImageUrl;
        patientImage.alt = "Image";
        patientImage.className = "patientImage";
        tr.appendChild(imageCell);

        var editCell = document.createElement("td");
        editCell.className = "MinimumWidth";
        tr.appendChild(editCell);

        var editButton = document.createElement("input");
        editButton.type = "button";
        editButton.value = "Edit";
        editButton.className = "btn btn-success";
        editButton.setAttribute("data-id", data[i].Id);
        editButton.onclick = function () { InitializeAndOpenPersonDialog(this.getAttribute("data-id")); };
        editCell.appendChild(editButton);
        tbody.appendChild(tr);
    }
}
