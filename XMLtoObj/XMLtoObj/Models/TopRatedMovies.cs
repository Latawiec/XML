using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Text;

namespace XMLtoObj.Models
{
    public class TopRatedMovies
    {
        public ObservableCollection<Movie> Movies { get; set; }
        public ObservableCollection<Author> Authors { get; set; }
        public ObservableCollection<Genre> Genres { get; set; }
        public ObservableCollection<Locale> Locales { get; set; }
    }
}
