using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls;

namespace Callboard
{
    public static class ImageLoader
    {
        public static string SaveImage(ref Alert alert, FileUpload file, string folderPath, string pattern, int itemId, string image_name="no-image.png")
        {
            if ((file.PostedFile != null) && (file.PostedFile.ContentLength > 0))
            {
                string[] types = { "jpeg", "jpg", "png", "bmp", "gif" };
                string fileName = System.IO.Path.GetFileName(file.PostedFile.FileName);
                string fileType = fileName.Split('.')[1];
                image_name = $"{pattern}_{itemId}.{fileType}";
                string SaveLocation = folderPath + "\\" + image_name;
                if (types.Contains(fileType))
                {
                    try
                    {
                        file.PostedFile.SaveAs(SaveLocation);
                        alert.AddMessageAlert("Файл успішно завантажено.");
                    }
                    catch (Exception ex)
                    {
                        alert.AddErrorAlert("Помилка при завантаженні зображення!");
                    }
                }
                else
                {
                    alert.AddErrorAlert("Помилка: файл не є зображенням!");
                }
            }
            return image_name;
        }
    }
}