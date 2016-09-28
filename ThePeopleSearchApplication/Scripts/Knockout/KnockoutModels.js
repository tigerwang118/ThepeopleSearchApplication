var KnockoutModel = {};
// Display Type
KnockoutModel.DisplayType = function (data) {
    var self = this;
    if (!data) {
        // set some default values
        data = {
            Name: '',
            Value: '',
            ImageClass: '',
            Selected: false
        };
    }
    self.Name = ko.observable(data.Name);
    self.Value = ko.observable(data.Value);
    self.ImageClass = ko.observable(data.ImageClass);
    self.Selected = ko.observable(data.Selected === true);
    self.css = ko.computed(function () {
        var selected = this.Selected() === true ? 'selected' : '';
        return this.ImageClass() + ' ' + selected;
    }, self);
};
//KnockoutModel.ViewModel = function (data) {
//    var self = this;
//    if (!data) {
//        // set some default values
//        data = {
//            People: undefined,
//        };
//    }
//    self.People=ko.observable(new KnockoutModel.People(data.People));
//};
// SelectListItem
KnockoutModel.SelectListItem = function (data) {
    var self = this;
    if (!data) {
        // set some default values
        data = {
            Text: '',
            Value: '',
            Selected: false
        };
    }
    self.Text = ko.observable(!data.Text ? '' : data.Text);
    self.Value = ko.observable(!data.Value ? '' : data.Value);
    self.Selected = ko.observable(!data.Selected ? false : data.Selected);
};


// Address Model
KnockoutModel.Address = function (data) {
    var self = this;
    if (!data) {
        // set some default values
        data = {
            Id: undefined,
            Street: '',
            City: '',
            State: '',
            PostalCode: '',
            Country:''
        };
    }
    self.Id = ko.observable(data.Id);
    self.Line1 = ko.observable(data.Street1);
    self.Line2 = ko.observable(data.Street2);
    self.Street = ko.computed(function () {
        var street = this.Street1();
        if (this.Street2()) {
            street = street + ', ' + this.Street2();
        }
        return street;
    }, self);
    self.City = ko.observable(data.City);
    self.State = ko.observable(data.State);
    self.PostalCode = ko.observable(data.PostalCode);
    self.Country = ko.observable(data.country);
};
// Person Model
KnockoutModel.Person = function (data) {
    var self = this; 
    if (!data) {
        // set some default values
        data = {
            
            FirstName: '',
            LastName: '',
            Interests: '',
            ImageUrl: '',
            Age:'',          
            Address: '',
            Id: ''
        };
    }
    self.Id = ko.observable(!data.Id ? '' : data.Id);
    self.FirstName = ko.observable(!data.FirstName ? '' : data.FirstName);
    self.LastName = ko.observable(!data.LastName ? '' : data.LastName);
    self.Age = ko.observable(!data.Age ? '' : data.Age);
    self.Interests = ko.observable(!data.Interests ? '' : data.Interests);
    self.ImageUrl = ko.observable(!data.ImageUrl ? '' : data.ImageUrl);
    self.Address = ko.observable(!data.Address ? '' : data.Address);
    self.destroy = function () {
        self = null;
    };
};
KnockoutModel.PeopleSearchModel = function (data) {
    var self = this;
    self.DisplayType = ko.observable(data.DisplayType);
    self.DisplayTypes = ko.observableArray([
    new KnockoutModel.DisplayType({ Name: 'Grid', Value: 'grid', ImageClass: 'ui-icon-display-type-grid', Selected: true }),
    new KnockoutModel.DisplayType({ Name: 'Image List', Value: 'imageList', ImageClass: 'ui-icon-display-type-list-with-image', Selected: false }),
    new KnockoutModel.DisplayType({ Name: 'List', Value: 'list', ImageClass: 'ui-icon-display-type-list', Selected: false })
    ]);
    //self.DisplayTypes = ko.observableArray(data.DisplayTypes);
    self.PageSize = ko.observable(data.PageSize);
    self.PageNumber = ko.observable(data.PageNumber);
    self.TotalPeople = ko.observable(data.TotalPeople);
    self.DisplaySizeValues = ko.observableArray(!data.DisplaySizeValues ? [] : $.map(data.DisplaySizeValues, function (selectListItem) {
        return new KnockoutModel.SelectListItem(selectListItem);
    }));
    self.SearchText = ko.observable(data.SearchText);
    self.FilterValue = ko.observable(data.FilterValue);
    self.FilterValues = ko.observableArray(!data.FilterValues ? [] : $.map(data.FilterValues, function (selectListItem) {
        return new KnockoutModel.SelectListItem(selectListItem);
    }));
    self.People = ko.observableArray([]);
    self.SortColumn = ko.observable(data.SortColumn);
    self.SortOrder = ko.observable(data.SortOrder);
    // used by the UI only
    self.grid = ko.observable();
    self.showSortColumns = ko.computed(function () {
        var selectedDisplayType = ko.observable(ko.utils.arrayFirst(this.DisplayTypes(), function (displayType) {
            return displayType.Value() == 'grid';
        }));
        return selectedDisplayType() ? selectedDisplayType().Selected() : false;
    }, self);
    self.sortColumns = ko.observableArray(!data.SortColumns ? [
            new KnockoutModel.SelectListItem({ Text: 'First Name', Value: 'FirstName', Selected: false }),
            new KnockoutModel.SelectListItem({ Text: 'Last Name', Value: 'LastName', Selected: false })
    ] : $.map(data.SortColumns, function (column) {
        return new KnockoutModel.SelectListItem(column);
    })
    ).sort(function (left, right) {
        return left.Text() == right.Text() ? 0 : (left.Text() < right.Text() ? -1 : 1);
    });
    self.sortColumnChanged = function (column) {
        debugger;
        self.SortOrder('asc');
        //self.GetPeople();
    };
    self.GetPeople = function () {
        $('.k-loading-mask').show();
        var data = {
            PageSize: self.PageSize(),
            PageNumber: self.PageNumber(),
            SearchText: self.SearchText(),
            FilterValue: self.FilterValue(),
            SortColumn: self.SortColumn(),
            SortOrder: self.SortOrder(),
            DisplayType: self.DisplayType()
        }
        $.getJSON('/Home/GetPeopleKnockout', data, function (result) {
            // update
            ko.utils.arrayForEach(self.People, function (person) {
                person.destroy();
            });
            self.People.removeAll(); debugger;
            self.People($.map(result.People, function (person) {
                return new KnockoutModel.Person(person);
            }));
            //console.log(self.People);
            // set up grid
            self.TotalPeople(result.TotalPeople);
            self.SortColumn(result.SortColumn);
            self.SortOrder(result.SortOrder); debugger;
            if (self.grid() && self.grid().dataSource) {
                self.grid().dataSource.total = function () {
                    return self.TotalPeople();
                };
                self.grid().dataSource.pageSize(self.PageSize() ? self.PageSize() : self.TotalPeople());
                self.grid().dataSource.sort({ field: self.SortColumn() + '()', dir: self.SortOrder() });
                $(self.grid().thead).find('[role="columnheader"]').find('.k-link').on('mousedown', function (e) {
                    var column = $(this).parent();
                    self.SortColumn(column.attr('data-field').replace('()', ''));
                    self.SortOrder(column.attr('data-dir') == 'asc' ? 'desc' : 'asc');
                    self.GetPeople();//
                    $(self.grid().thead).find('.k-link').off('mousedown');
                });

                if (self.PageNumber() != null)
                    self.grid().pager.page(self.PageNumber());
                else
                    self.grid().pager.page(1);
            }
            // populate new display size values
            self.DisplaySizeValues(!result.DisplaySizeValues ? [] : $.map(result.DisplaySizeValues, function (selectListItem) {
                return new KnockoutModel.SelectListItem(selectListItem);
            }));
            
   $('.k-loading-mask').fadeOut(1000);
        });
    };
    self.kendoGridRowTemplate = ko.observable(self.DisplayType());// console.log(selectedDisplayType.Value());
    self.setDisplayType = function (selectedDisplayType) {
        if (selectedDisplayType.Value()) {
            var currentlySelected = ko.observable(ko.utils.arrayFirst(self.DisplayTypes(), function (displayType) {
                return displayType.Selected() === true;
            }));
            currentlySelected().Selected(false);
            var newlySelected = ko.observable(ko.utils.arrayFirst(self.DisplayTypes(), function (displayType) {
                return displayType.Value() == selectedDisplayType.Value();
            }));
            newlySelected().Selected(true);
            self.DisplayType(newlySelected().Value());
            self.kendoGridRowTemplate(selectedDisplayType.Value());
            self.PageNumber(1);
            self.GetPeople();//
        }
    };
    self.setDisplayType(new KnockoutModel.DisplayType({ Value: self.DisplayType() }));
    self.gridDataBound = function (e) {
        var person = $('.personList .kendoGrid .personInGrid');
        var personGrid = person.closest('tbody');
        personGrid.prepend('<tr><td></td></tr>');
        person
            .unwrap() /*Remove td*/
            .unwrap() /*Remove tr*/
            .appendTo(personGrid.find('td:first'));
    };
    self.pageChange = function () {
        if (self.PageNumber() != self.grid().pager.page()) {
            self.PageNumber(self.grid().pager.page());
            self.GetPeople();
        }
    };
    self.oldSearchText = ko.observable();
    self.SearchText.subscribe(function (oldValue) {
        self.oldSearchText(oldValue);
    }, null, 'beforeChange');
    self.searchTextTimeout = ko.observable();
    self.SearchText.subscribe(function (newValue) {
        if (self.oldSearchText() != newValue) {
            if (self.searchTextTimeout()) {
                clearTimeout(self.searchTextTimeout()); // stop the timeout from happening, we do this here so that we can only have one timeout that happens and we only get new persons one time
            }
            var timeout = setTimeout(function () {
                self.PageNumber(1);
                debugger;
                self.GetPeople(); 
            }, 1000); // wait to make sure the user done typing before getting
            self.searchTextTimeout(timeout);
        }
        return newValue;
    });
    self.oldFilterValue = ko.observable();
    self.FilterValue.subscribe(function (oldValue) {
        self.oldFilterValue(oldValue);
    }, null, 'beforeChange');
    self.FilterValue.subscribe(function (newValue) {
        if (self.oldFilterValue() != newValue) {
            self.PageNumber(1);
            //self.GetPeople();
        }
        return newValue;
    });
    self.oldPageSize = ko.observable();
    self.PageSize.subscribe(function (oldValue) {
        self.oldPageSize(oldValue);
    }, null, 'beforeChange');
    self.PageSize.subscribe(function (newValue) {
        debugger;
        if (self.oldPageSize()!=null || self.oldPageSize() != newValue) {
            self.PageNumber(1);
            self.GetPeople(); //
        }
    });
    self.PageNumber.subscribe(function (newValue) {
        if (newValue != self.PageNumber()) {
            console.log(self.PageNumber() + ':PageNumber:' + newValue);
            self.GetPeople();
        }
        return newValue;
    });
};

KnockoutModel.BindPeopleSearchModel = function (data) {
        var model = new KnockoutModel.PeopleSearchModel(data);
        debugger; 
        ko.applyBindings(model); $('.k-loading-mask').fadeOut(1000);
        return model;
};