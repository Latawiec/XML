using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Text;

namespace XMLtoObj.Models
{
    public class Movie
    {
        public string Id { get; set; }
        public ObservableCollection<Title> Titles { get; set; } =new ObservableCollection<Title>()
        {
            new Title(),
            new Title()
        };
        public string Rate { get; set; }
        public string Director { get; set; }
        public string Duration { get; set; }
        public ReleaseDate ReleaseDate { get; set; } = new ReleaseDate();
    }
}
