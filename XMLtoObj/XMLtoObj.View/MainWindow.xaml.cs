using System;
using System.Linq;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Forms;
using XMLtoObj.Models;
using XMLtoObj.Service;
using Binding = System.Windows.Data.Binding;
using MessageBox = System.Windows.MessageBox;

namespace XMLtoObj.View
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        private TopRatedMovies _moviesList;
        private readonly string _defaultPath = "../../../movies_list.xml";
        private readonly string _defaultSavePath = "../../../temporary.xml";
        private readonly string _defaultSchemaPath = "../../../../moviesList.xsd";

        private readonly string _defaultXslPath = "../../../../toHelperXML.xsl";
        private readonly string _defaultTransformPath = "../../../moviesListHelper.xml";

        private readonly string _defaultXslHtmlPath = "../../../../toXHTML.xsl";
        private readonly string _defaultTransformHtmlPath = "../../../moviesList.xhtml";

        private readonly string _defaultXslSvgPath = "../../../../toSVG.xsl";
        private readonly string _defaultTransformSvgPath = "../../../moviesList.svg";

        private readonly string _defaultXslTxtPath = "../../../../toTXT.xsl";
        private readonly string _defaultTransformTxtPath = "../../../moviesList.txt";

        private void Transform()
        {
            XMLService.TransfromXML(_defaultXslPath, _defaultPath, _defaultTransformPath);

            //toHTML
            XMLService.TransfromXML(_defaultXslHtmlPath, _defaultTransformPath, _defaultTransformHtmlPath);

            //toSVG
            XMLService.TransfromXML(_defaultXslSvgPath, _defaultTransformPath, _defaultTransformSvgPath);
        
            //toTXT
            XMLService.TransfromXML(_defaultXslTxtPath, _defaultTransformPath, _defaultTransformTxtPath);
        }

        public MainWindow()
        {
            Transform();
            InitializeComponent();
            var moviesList = XMLService.ReadXml(_defaultPath);
            _moviesList = moviesList;
        }

        private bool ValidationAgainstSchema(string path, string schemaPath)
        {
            var result = MessageBoxResult.Yes;
            var validationResult = XMLService.ValidateAgainstSchema(path, schemaPath);
            if (!validationResult.Item1)
            {
                MessageBoxButton buttons = MessageBoxButton.YesNo;
                string caption = "Bład podczas walidacji względem schemy";
                result = MessageBox.Show(validationResult.Item2 + '\n' + "Kontynuować mimo to?", caption, buttons);

            }

            return (result == MessageBoxResult.Yes);
        }
        
        private void OpenXML(object sender, RoutedEventArgs e)
        {
            var validationResult = ValidationAgainstSchema(_defaultPath, _defaultSchemaPath);
            if (!validationResult) return;

            var moviesList = XMLService.ReadXml(_defaultPath);
            _moviesList = moviesList;
        }

        private void SaveXML(object sender, RoutedEventArgs e)
        {
            try
            {
                XMLService.SaveChangesInXML(_defaultPath, _defaultSavePath, _moviesList);

                var validationResult = XMLService.ValidateAgainstSchema(_defaultSavePath, _defaultSchemaPath);
                if (!validationResult.Item1)
                {
                    MessageBox.Show(validationResult.Item2, "Zapisano");
                }
                else
                {
                    MessageBox.Show("Plik jest poprawny względem schemy","Zapisano");
                }
            }
            catch (ArgumentException exception)
            {
                MessageBox.Show("Wszystkie pola nowego wiersza muszą być wypełnione", "Błąd");
            }

        }

        private void GetAuthors(object sender, RoutedEventArgs e)
        {
            DataGrid.ItemsSource = _moviesList.Authors;
            DataGrid.Columns.Clear();
            DataGrid.Columns.Add(new DataGridTextColumn {Header = "Name", Binding = new Binding("Name")});

        }

        private void GetGenres(object sender, RoutedEventArgs e)
        {
            var myCollection = _moviesList.Genres;
            DataGrid.ItemsSource = myCollection;
            DataGrid.InitializingNewItem += (senderObject, args) =>
            {
                string nextToLastId = myCollection[myCollection.Count - 2].Id;
                myCollection.Last().Id = NextId(nextToLastId);
            };


            DataGrid.Columns.Clear();
            DataGrid.Columns.Add(new DataGridTextColumn {Header = "Id", Binding = new Binding("Id"), IsReadOnly = true });
            DataGrid.Columns.Add(new DataGridTextColumn {Header = "Name", Binding = new Binding("Name")});
        }

        private void GetLocales(object sender, RoutedEventArgs e)
        {
            var myCollection = _moviesList.Locales;
            DataGrid.ItemsSource = myCollection;
            DataGrid.InitializingNewItem += (senderObject, args) =>
            {
                string nextToLastId = myCollection[myCollection.Count - 2].Id;
                myCollection.Last().Id = NextId(nextToLastId);
            }; 

          
            DataGrid.Columns.Clear();
            DataGrid.Columns.Add(new DataGridTextColumn { Header = "Id", Binding = new Binding("Id"), IsReadOnly = true});
            DataGrid.Columns.Add(new DataGridTextColumn { Header = "Name", Binding = new Binding("Name") });
        }

        private string NextId(string id)
        {
            string charPart = id[0].ToString();
            int intPart = Convert.ToInt32(id.Substring(1));
            intPart++;
            return charPart + intPart.ToString();
        }

        private void GetMovies(object sender, RoutedEventArgs e)
        {
            var myCollection = _moviesList.Movies;
            DataGrid.ItemsSource = myCollection;
            DataGrid.InitializingNewItem += (senderObject, args) =>
            {
       
            };



            DataGrid.Columns.Clear();

            DataGrid.Columns.Add(new DataGridTextColumn { Header = "Title 1", Binding = new Binding("Titles[0].TitleValue") { Mode = BindingMode.TwoWay } });
            DataGrid.Columns.Add(new DataGridComboBoxColumn { Header = "Locale Id", ItemsSource = _moviesList.Locales.Select(x => x.Id).ToList(), SelectedValueBinding = new Binding("Titles[0].LocaleId") { Mode = BindingMode.TwoWay } });
            DataGrid.Columns.Add(new DataGridCheckBoxColumn { Header = "Original?", Binding = new Binding("Titles[0].Original") { Mode = BindingMode.TwoWay } });
            DataGrid.Columns.Add(new DataGridTextColumn { Header = "Title 2", Binding = new Binding("Titles[1].TitleValue") { Mode = BindingMode.TwoWay } });
            DataGrid.Columns.Add(new DataGridComboBoxColumn { Header = "Locale Id", ItemsSource = _moviesList.Locales.Select(x => x.Id).ToList(), SelectedValueBinding = new Binding("Titles[1].LocaleId") { Mode = BindingMode.TwoWay } });
            DataGrid.Columns.Add(new DataGridCheckBoxColumn { Header = "Original?", Binding = new Binding("Titles[1].Original") { Mode = BindingMode.TwoWay } });
            DataGrid.Columns.Add(new DataGridComboBoxColumn { Header = "Genre Id", ItemsSource = _moviesList.Genres.Select(x => x.Id).ToList(), SelectedValueBinding = new Binding("Id") });
            DataGrid.Columns.Add(new DataGridTextColumn { Header = "Rate", Binding = new Binding("Rate") });
            DataGrid.Columns.Add(new DataGridTextColumn { Header = "Director", Binding = new Binding("Director") });
            DataGrid.Columns.Add(new DataGridTextColumn { Header = "Duration", Binding = new Binding("Duration") });
            DataGrid.Columns.Add(new DataGridTextColumn { Header = "ReleaseDate Day", Binding = new Binding("ReleaseDate.Day") { Mode = BindingMode.TwoWay } });
            DataGrid.Columns.Add(new DataGridTextColumn { Header = "ReleaseDate Month", Binding = new Binding("ReleaseDate.Month") { Mode = BindingMode.TwoWay } });
            DataGrid.Columns.Add(new DataGridTextColumn { Header = "ReleaseDate Year", Binding = new Binding("ReleaseDate.Year") { Mode = BindingMode.TwoWay }});


        }
    }
}

