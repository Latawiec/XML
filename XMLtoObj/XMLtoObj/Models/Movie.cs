using System;
using System.Collections.Generic;
using System.Text;

namespace XMLtoObj.Models
{
    public class Movie
    {
        public string Id { get; set; }
        public IEnumerable<Title> Titles { get; set; }
        public string Rate { get; set; }
        public string Director { get; set; }
        public IEnumerable<ReleaseDate> ReleaseDate { get; set; }
    }
}
