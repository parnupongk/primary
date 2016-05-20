using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.Configuration;
using System.Data.OleDb;
using PrimaryHaul.WebUI.App_Code;
using PrimaryHaul_WS;
using PPH_SC;
using NPOI.HSSF.UserModel;
using NPOI.HPSF;
using NPOI.POIFS.FileSystem;
using NPOI.SS.UserModel;
using System.IO;

namespace PrimaryHaul.WebUI
{
    public partial class report_kpi : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(Request.QueryString["week"] as string)) { hidWeek.Value = Request.QueryString["week"].ToString(); }
            
            /*string filename = "kpi_d.xls";
            Response.ContentType = "application/vnd.ms-excel";
            Response.AddHeader("Content-Disposition", string.Format("attachment;filename={0}", filename));
            Response.Clear();

            InitializeWorkbook();
            GenerateData();
            Response.BinaryWrite(WriteToStream().GetBuffer());
            Response.End();*/

        }

        HSSFWorkbook hssfworkbook;

        MemoryStream WriteToStream()
        {
            MemoryStream file = new MemoryStream();
            hssfworkbook.Write(file);
            return file;
        }

        void GenerateData()
        {
            ISheet sheet1 = hssfworkbook.CreateSheet("KPI Report‏");

            sheet1.CreateRow(0).CreateCell(0).SetCellValue("Report KPI");
            int x = 1;
            for (int i = 1; i <= 15; i++)
            {
                IRow row = sheet1.CreateRow(i);
                for (int j = 0; j < 15; j++)
                {
                    row.CreateCell(j).SetCellValue(x++);
                }
            }
        }

        void InitializeWorkbook()
        {
            hssfworkbook = new HSSFWorkbook();

            DocumentSummaryInformation dsi = PropertySetFactory.CreateDocumentSummaryInformation();
            dsi.Company = "Tesco Lotus";
            hssfworkbook.DocumentSummaryInformation = dsi;

            SummaryInformation si = PropertySetFactory.CreateSummaryInformation();
            si.Subject = "Report KPI";
            hssfworkbook.SummaryInformation = si;
        }


        
    }
}