$code = @"
using System;
using System.IO;
using System.Drawing;
using System.Drawing.Imaging;
using Windows.Data.Pdf;
using Windows.Storage;
using Windows.Storage.Streams;

public class PdfRenderer {
    public static void RenderPdf(string pdfPath, string outputDir) {
        Directory.CreateDirectory(outputDir);
        var file = StorageFile.GetFileFromPathAsync(pdfPath).AsTask().Result;
        var pdfDoc = PdfDocument.LoadFromFileAsync(file).AsTask().Result;
        Console.WriteLine("Total Pages: " + pdfDoc.PageCount);

        for (uint i = 0; i < pdfDoc.PageCount; i++) {
            using (var page = pdfDoc.GetPage(i)) {
                var stream = new InMemoryRandomAccessStream();
                page.RenderToStreamAsync(stream).AsTask().Wait();
                using (var netStream = stream.AsStreamForRead())
                using (var img = Image.FromStream(netStream)) {
                    string outPath = Path.Combine(outputDir, $"page_{i + 1}.png");
                    img.Save(outPath, ImageFormat.Png);
                    Console.WriteLine($"Saved page {i + 1} to {outPath}");
                }
            }
        }
    }
}
"@

# Note: In PowerShell WinRT async can be handled via System.WindowsRuntime System.Runtime.WindowsRuntime
