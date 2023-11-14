using CommunityToolkit.Maui.Views;
using Ejercicio2_2.Models;
using Ejercicio2_2.Views;
using SQLite;

namespace Ejercicio2_2
{
    public partial class MainPage : ContentPage
    {
        public MainPage()
        {
            InitializeComponent();
        }

        private async void btnGuardar_Clicked(object sender, EventArgs e)
        {
            try
            {
                if (string.IsNullOrWhiteSpace(_txtNombre.Text) || string.IsNullOrWhiteSpace(_txtDescripcion.Text))
                {
                    await ShowAlert("Error", "Por favor, complete todos los campos y firme antes de guardar.");
                    return;
                }

                byte[] imagenBytes = await getSignatureToImage();

                if (imagenBytes == null || imagenBytes.Length == 0)
                {
                    await ShowAlert("Error", "Por favor, firme antes de guardar.");
                    return;
                }

                Constructor nuevoConstructor = new Constructor
                {
                    nombre = _txtNombre.Text,
                    descripcion = _txtDescripcion.Text,
                    imageSignature = imagenBytes
                };

                var resultado = await App.BaseDatos.EmpleadoGuardar(nuevoConstructor);

                clear();

                ((DrawingView)this.FindByName<DrawingView>("drawingView")).Clear();

                await ShowAlert("Éxito", "Registro Guardado correctamente.");
            }
            catch (SQLiteException ex)
            {
                await ShowAlert("Error", $"Error de base de datos: {ex.Message}");
            }
            catch (Exception ex)
            {
                await ShowAlert("Error", $"Hubo un error al intentar guardar: {ex.Message}");
            }
        }

        private async Task<byte[]> getSignatureToImage()
        {
            using (MemoryStream stream = new MemoryStream())
            {
                Stream imagenStream = await ((DrawingView)this.FindByName<DrawingView>("drawingView")).GetImageStream(200, 200);
                await imagenStream.CopyToAsync(stream);
                return stream.ToArray();
            }
        }

        private void clear()
        {
            _txtNombre.Text = "";
            _txtDescripcion.Text = "";
        }

        private async Task ShowAlert(string titulo, string mensaje)
        {
            await DisplayAlert(titulo, mensaje, "Aceptar");
        }


        private async void btnLista_Clicked(object sender, EventArgs e)
        {
            await Navigation.PushAsync(new Lista());
        }
    }
}