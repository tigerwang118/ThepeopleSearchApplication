using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace ThePeopleSearchApplication.Models
{
    public class PeopleSearchModel
    {

        public enum PeopleDisplayType
        {
            grid = 1,
            list = 2,
            imageList = 3
        }

        public virtual string DisplayType { get; set; }
        public virtual IList<DisplayTypeModel> DisplayTypes { get; set; }

        public virtual int? PageSize { get; set; }

        public virtual int PageNumber { get; set; }

        public virtual int TotalPeople { get; set; }

        public virtual SelectList DisplaySizeValues { get; set; }

        public virtual string SearchText { get; set; }

        public string FilterValue { get; set; }

        public virtual SelectList FilterValues { get; set; }

        public virtual IList<PeopleModel> People { get; set; }

        public virtual string SortColumn { get; set; }

        public virtual string SortOrder { get; set; }

        public virtual SelectList SortColumns { get; set; }

        public PeopleSearchModel()
        {
            this.Setup();
        }

        private void Setup()
        {
            this.DisplayType = PeopleDisplayType.grid.ToString();
            this.PageNumber = 1;
            var displaySizeValues = new List<SelectListItem>(){
                new SelectListItem(){ Text = "All", Value = "" },
                new SelectListItem(){ Text = "10", Value = "10" },
                new SelectListItem(){ Text = "25", Value = "25" },
                new SelectListItem(){ Text = "50", Value = "50" },
                new SelectListItem(){ Text = "100", Value = "100" }
            };
            this.DisplaySizeValues = new SelectList(displaySizeValues, "Value", "Text", this.PageSize);
            this.SortOrder = "asc";
            this.FilterValue = null;
            this.People = new List<PeopleModel>();
        }
    }
}