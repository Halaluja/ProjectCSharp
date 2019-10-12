using Microsoft.WindowsAzure.Storage;
using Microsoft.WindowsAzure.Storage.Blob;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.UI.HtmlControls;

namespace WebApp.Controllers
{
    public class BlobsController : Controller
    {
        // GET: Blobs
        protected HtmlInputFile filMyFile;
        public ActionResult Index()
        {
            return View("View");
        }
        public void GetCloudBlobContainer(List<HttpPostedFileBase> list, string key)
        {
            string conString = ConfigurationManager.ConnectionStrings["AzureStorage"].ConnectionString;
            string destContainer = ConfigurationManager.AppSettings["destContainer"];

            CloudStorageAccount sa = CloudStorageAccount.Parse(conString);
            CloudBlobClient bc = sa.CreateCloudBlobClient();
            CloudBlobContainer container = bc.GetContainerReference(destContainer); //Tạo new container
            container.CreateIfNotExists();

            BlobContainerPermissions per = container.GetPermissions();
            per.PublicAccess = BlobContainerPublicAccessType.Container;
            container.SetPermissions(per);



            foreach (var item in list)
            {
                key = key + "-" + item.FileName; //Tên của file trên azure
                UploadBlob(container, key, item);
            }
        }

        public void UploadBlob(CloudBlobContainer container, string key, HttpPostedFileBase fileName)
        {
            CloudBlockBlob b = container.GetBlockBlobReference(key);

            b.UploadFromStream(fileName.InputStream);

        }
        [HttpPost]
        public ActionResult showFile()
        {
            List<HttpPostedFileBase> list = new List<HttpPostedFileBase>();
            string key = Request.Params["key"];
            for (int i = 0; i < Request.Files.Count; i++)
            {
                HttpPostedFileBase filePosted = Request.Files[i];
                if (filePosted != null && filePosted.ContentLength > 0)
                {
                    list.Add(filePosted);
                }
            }
            GetCloudBlobContainer(list, key);
            return RedirectToAction("Index");
        }
    }
}