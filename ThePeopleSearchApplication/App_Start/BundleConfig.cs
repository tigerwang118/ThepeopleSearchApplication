using System.Web;
using System.Web.Optimization;

namespace ThePeopleSearchApplication
{
    public class BundleConfig
    {
        // For more information on Bundling, visit http://go.microsoft.com/fwlink/?LinkId=254725
        public static void RegisterBundles(BundleCollection bundles)
        {
            bundles.Add(new ScriptBundle("~/bundles/jquery").Include(
                        "~/Scripts/jquery-1.8.1.js"));

            bundles.Add(new ScriptBundle("~/bundles/jqueryui").Include(
                        "~/Scripts/jquery-ui-{version}.js"));

            bundles.Add(new ScriptBundle("~/bundles/jqueryval").Include(
                        "~/Scripts/jquery.unobtrusive*",
                        "~/Scripts/jquery.validate*"));
            bundles.Add(new ScriptBundle("~/bundles/jqueryui").Include(
                       "~/Scripts/People.js","~/Scripts/Custom.js"));
            bundles.Add(new ScriptBundle("~/bundles/modernizr").Include(
                        "~/Scripts/modernizr-*"));
            #region Kendo UI

            bundles.Add(new ScriptBundle("~/bundles/kendo").Include(
                 "~/Scripts/kendo/2014.1.318/kendo.web.min.js",
                 "~/Scripts/kendo/2014.1.318/kendo.aspnetmvc.min.js",
                 "~/Scripts/kendo/2014.1.318/cultures/kendo.culture.en-US.min.js",
                 "~/Scripts/kendo/2014.1.318/cultures/kendo.culture.en-CA.min.js",
                 "~/Scripts/kendo/2014.1.318/cultures/kendo.culture.fr-CA.min.js"));

            bundles.Add(new StyleBundle("~/Content/kendo/css").Include(
                "~/Content/kendo/2014.1.318/kendo.common.min.css",
                "~/Content/kendo/2014.1.318/kendo.default.min.css",
                "~/Content/KendoMenu.css",
                "~/Content/KendoGrid.css",
                "~/Content/KendoTooltip.css"
                ));
            #endregion

            bundles.Add(new StyleBundle("~/Content/themes/base/css").Include(
                        "~/Content/themes/base/jquery.ui.core.css",
                        "~/Content/themes/base/jquery.ui.resizable.css",
                        "~/Content/themes/base/jquery.ui.selectable.css",
                        "~/Content/themes/base/jquery.ui.accordion.css",
                        "~/Content/themes/base/jquery.ui.autocomplete.css",
                        "~/Content/themes/base/jquery.ui.button.css",
                        "~/Content/themes/base/jquery.ui.dialog.css",
                        "~/Content/themes/base/jquery.ui.slider.css",
                        "~/Content/themes/base/jquery.ui.tabs.css",
                        "~/Content/themes/base/jquery.ui.datepicker.css",
                        "~/Content/themes/base/jquery.ui.progressbar.css",
                        "~/Content/themes/base/jquery.ui.theme.css"));

            bundles.Add(new StyleBundle("~/Content/css").Include(
               "~/Content/css/font-awesome.min.css","~/Content/css/custom.css"
                ));
        }
    }
}