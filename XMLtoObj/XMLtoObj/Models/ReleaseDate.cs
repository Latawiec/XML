using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.ComponentModel;
using System.Runtime.CompilerServices;
using System.Text;

namespace XMLtoObj.Models
{
    public class ReleaseDate : INotifyPropertyChanged
    {
        public string Day { get; set; }
        public string Month { get; set; }
        public string Year { get; set; }
        public event PropertyChangedEventHandler PropertyChanged;

        protected virtual void OnPropertyChanged([CallerMemberName] string propertyName = null)
        {
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
        }
    }

    public class ReleaseDateReader : INotifyPropertyChanged
    {
        ObservableCollection<ReleaseDate> _ReleaseDates;

        public ObservableCollection<ReleaseDate> ReleaseDates
        {
            get { return _ReleaseDates; }
            private set
            {
                _ReleaseDates = value;
                NotifyPropertyChanged();
            }
        }

        public ReleaseDateReader()
        {
            ReleaseDates = new ObservableCollection<ReleaseDate>();
        }

        public event PropertyChangedEventHandler PropertyChanged;

        private void NotifyPropertyChanged([CallerMemberName] String propertyName = "")
        {
            if (PropertyChanged != null)
            {
                PropertyChanged(this, new PropertyChangedEventArgs(propertyName));
            }
        }

    }
}