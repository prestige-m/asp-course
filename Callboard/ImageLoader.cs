using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls;

namespace Callboard
{
    public static class ImageLoader
    {
        public static string SaveImage(FileUpload file, string folderPath)
        {
            string loadResult;
            if ((file.PostedFile != null) && (file.PostedFile.ContentLength > 0))
            {
                string[] types = { "jpeg", "jpg", "png", "bmp", "gif" };
                string fileName = System.IO.Path.GetFileName(file.PostedFile.FileName);
                string fileType = "." + fileName.Split('.')[1];
                string newName = "item_" + fileType;
                string SaveLocation = folderPath + "\\" + newName;
                if (types.Contains(fileType))
                {
                    try
                    {
                        file.PostedFile.SaveAs(SaveLocation);
                        loadResult = Alert.getMessageAlert("Файл успішно завантажено.");
                    }
                    catch (Exception ex)
                    {
                    }
                }
                else
                {
                    loadResult = Alert.getErrorAlert("Помилка: файл не є зображенням!");
                }
            }
            return loadResult;
        }
    }
}