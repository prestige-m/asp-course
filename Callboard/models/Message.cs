using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Callboard.models
{
    public class Message
    {
        public int ID { get; private set; }

        public string Title { get; private set; }

        public string Prebody { get; private set; }

        public string Autor { get; private set; }


       /* public Article(
              int id,
              DateTime addDate,
              string title,
              string prebody,
              string body,
              float rating,
              int viewCount,
              string icon,
              string autor)
        {
            this.Id = id;
            this.AddDate = addDate;
            this.Category = category;
            this.Title = title;
            this.Prebody = prebody;
            this.Rating = rating;
            this.ViewCount = viewCount;
            this.Icon = icon;
            this.Autor = autor;
        }*/
    }
}