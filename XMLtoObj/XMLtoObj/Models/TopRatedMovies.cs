using System;
using System.Collections.Generic;
using System.Text;

namespace XMLtoObj.Models
{
    public class TopRatedMovies
    {
        public IEnumerable<Movie> Movies { get; set; }
        public IEnumerable<Author> Authors { get; set; }
        public IEnumerable<Genre> Genres { get; set; }
        public IEnumerable<Locale> Locales { get; set; }
    }
}
