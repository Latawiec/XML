using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml.Linq;
using AutoMapper;
using XMLtoObj.Models;

namespace XMLtoObj.Service
{
    public static class XMLService
    {
        public static TopRatedMovies ReadXml(string path)
        {
            //initialize mapper
            var config = new MapperConfiguration(cfg => cfg.CreateMissingTypeMaps = true);
            var mapper = config.CreateMapper();

            //read document
            XDocument document = XDocument.Load(path);

            var authors = document.Descendants("author").Select(genre => new
            {
                Name = genre.Value,
            }).Select(mapper.Map<Author>).ToList();

            var genres = document.Descendants("genre").Select(genre => new
            {
                Id = genre.Attribute("id_g")?.Value,
                Name = genre.Value,
            }).Select(mapper.Map<Genre>).ToList();

            var locales = document.Descendants("localeId").Select(locale => new
            {
                Id = locale.Attribute("id_lang")?.Value,
                Name = locale.Value,
            }).Select(mapper.Map<Locale>).ToList();

            var movies = document.Descendants("movie").Select(movie => new
            {
                Id = movie.Attribute("genre_id_ref")?.Value,
                Titles = movie.Descendants("title").Select(_ => new
                {
                    LocaleId = _.Attribute("locale_id_ref")?.Value,
                    Original = _.Attribute("original")?.Value,
                    TitleValue = _.Value,
                }).Select(mapper.Map<Title>).ToList(),
                Rate = movie.Element("rate")?.Value,
                Director = movie.Element("director")?.Value,
                Duration = movie.Element("duration")?.Value,
                ReleaseDate = movie.Descendants("release_date").Select(_ => new
                {
                    Day = _.Element("day")?.Value,
                    Month = _.Element("month")?.Value,
                    Year = _.Element("year")?.Value,
                }).Select(mapper.Map<ReleaseDate>).ToList(),
            }).Select(mapper.Map<Movie>).ToList();
           
            return new TopRatedMovies
            {
                Authors = authors,
                Genres = genres,
                Locales = locales,
                Movies = movies
            };
        }
    }
}
