unit untMain;

interface

uses
     Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
     Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ActiveX, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.OleCtrls, SHDocVw,
     MSHTML, Printers;

type
     TfrmMain = class(TForm)
          WebBrowser1: TWebBrowser;
          Panel1: TPanel;
          btnLoad: TButton;
          btnPrint1: TButton;
          btnPrint2: TButton;
          btnPrint3: TButton;
          procedure btnLoadClick(Sender: TObject);
          procedure btnPrint1Click(Sender: TObject);
          procedure btnPrint2Click(Sender: TObject);
          procedure btnPrint3Click(Sender: TObject);
     private
          { Private declarations }
     public
          { Public declarations }
     end;

var
     frmMain: TfrmMain;

implementation

{$R *.dfm}

procedure WBLoadHTML(WebBrowser: TWebBrowser; HTMLCode: string);
var
     sl: TStringList;
     ms: TMemoryStream;
begin
     WebBrowser.Navigate('about:blank');
     while WebBrowser.ReadyState < READYSTATE_INTERACTIVE do
          Application.ProcessMessages;

     if Assigned(WebBrowser.Document) then
     begin
          sl := TStringList.Create;
          try
               ms := TMemoryStream.Create;
               try
                    sl.Text := HTMLCode;
                    sl.SaveToStream(ms);
                    ms.Seek(0, 0);
                    (WebBrowser.Document as IPersistStreamInit).Load(TStreamAdapter.Create(ms));
               finally
                    ms.Free;
               end;
          finally
               sl.Free;
          end;
     end;
end;

procedure TfrmMain.btnLoadClick(Sender: TObject);
var
     sHTML: string;
begin
     sHTML :=       '<HTML>' +
                    '<HEAD>' +
                    '<TITLE> HTML Document Model </TITLE>' +
                    '</HEAD>' +
                    '<BODY>' +
                    '<B> HTML Document Model </B>' +
                    'This here you apply HTML commands.'+
                    '</BODY>' +
                    '</HTML>';
     //
     WBLoadHTML(WebBrowser1, sHTML);
end;

procedure TfrmMain.btnPrint1Click(Sender: TObject);
var
     vIn, vOut: OleVariant;
begin
     while WebBrowser1.ReadyState <> READYSTATE_COMPLETE do
          Application.HandleMessage;
     //
     WebBrowser1.HandleNeeded;
     //
     WebBrowser1.ControlInterface.ExecWB(OLECMDID_PRINT, OLECMDEXECOPT_PROMPTUSER, vIn, vOut);
end;

procedure TfrmMain.btnPrint2Click(Sender: TObject);
var
     vIn, vOut: OleVariant;
begin
     while WebBrowser1.ReadyState <> READYSTATE_COMPLETE do
          Application.HandleMessage;
     //
     WebBrowser1.HandleNeeded;
     //
     WebBrowser1.ControlInterface.ExecWB(OLECMDID_PRINT, OLECMDEXECOPT_DONTPROMPTUSER, vIn, vOut);
end;

procedure TfrmMain.btnPrint3Click(Sender: TObject);
var
     r: TRect;
     sh, ph: HDC;
begin
     OleInitialize(nil);
     //
     while WebBrowser1.ReadyState <> READYSTATE_COMPLETE do
          Application.HandleMessage;

     // Printer.PrinterIndex:=//set selected printer here
     Printer.BeginDoc;
     try
          Printer.Canvas.Lock;
          try
               sh := GetDC(0);
               ph := Printer.Canvas.Handle;

               // TODO: make rect a bit smaller for a page margin
               // TODO: get page size from printer settings, assume A4 here (210x297mm)
               r.Left := 0;
               r.Top := 0;
               r.Right := 550 * GetDeviceCaps(sh, LOGPIXELSX) div 254;
               r.Bottom := 750 * GetDeviceCaps(sh, LOGPIXELSY) div 254;
               //r.Right := 2100 * GetDeviceCaps(sh, LOGPIXELSX) div 254;
               //r.Bottom := 2970 * GetDeviceCaps(sh, LOGPIXELSY) div 254;

               WebBrowser1.BoundsRect := r;

               SetMapMode(ph, MM_ISOTROPIC);
               SetWindowExtEx(ph, r.Right, r.Bottom, nil);
               SetViewportExtEx(ph, r.Right, r.Bottom, nil);
               r.Right := GetDeviceCaps(ph, HORZRES) - 1;
               r.Bottom := GetDeviceCaps(ph, VERTRES) - 1;

               (WebBrowser1.ControlInterface as IViewObject).Draw(DVASPECT_CONTENT, 1, nil, nil, 0, ph, @r, nil, nil, 0);
          finally
               Printer.Canvas.Unlock;
          end;
          Printer.EndDoc;
     except
          Printer.Abort;
          raise;
     end;
end;

end.
