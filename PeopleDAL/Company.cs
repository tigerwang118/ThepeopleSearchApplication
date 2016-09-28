//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace PeopleDAL
{
    using System;
    using System.Collections.Generic;
    
    public partial class Company
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Company()
        {
            this.Centers = new HashSet<Center>();
        }
    
        public System.Guid ID { get; set; }
        public int CompanyID { get; set; }
        public string CompanyName { get; set; }
        public string CompanyRoleName { get; set; }
        public string CompanyTheme { get; set; }
        public string CompanyEmail { get; set; }
        public Nullable<int> PaymentMethodDefault { get; set; }
        public string URL { get; set; }
        public string CompanyLogo { get; set; }
        public Nullable<System.DateTime> CreatedDateUtc { get; set; }
        public string CreatedBy { get; set; }
        public string LastModifiedBy { get; set; }
        public Nullable<System.DateTime> LastModifiedDateUtc { get; set; }
        public bool Deleted { get; set; }
    
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Center> Centers { get; set; }
    }
}