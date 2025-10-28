//Kelas Abtrak Transportasi

abstract class Transportasi{
  String id, nama;
  final double _tarifDasar;
  int kapasitas;

  Transportasi(this.id, this.nama, this._tarifDasar, this.kapasitas);
  
  double get tarifDasar => _tarifDasar;
  double hitungTarif(int jumlahPenumpang);
  void tampilInfo();
}

//Kelas Taksi
class Taksi extends Transportasi{
  double jarak;

  Taksi(super.id, super.nama, super._tarifDasar, super.kapasitas,this.jarak);

  double hitungTarif (int _) => tarifDasar * jarak;
  void tampilInfo() => print ("Taksi $nama | Jarak: $jarak km");
}

//Kelas BUs
class Bus extends Transportasi{
bool adaWifi;
Bus(super.id, super.nama, super._tarifDasar, super.kapasitas, this.adaWifi);

double hitungTarif(int jml)=> (tarifDasar * jml) + (adaWifi ? 5000 : 0);
void tampilInfo()=> print ("Bus: $nama \ Wifi: $adaWifi");
}

//Kelas Pesawat
class Pesawat extends Transportasi{
  String kelas;
  Pesawat(super.id, super.nama, super._tarifDasar, super.kapasitas, this.kelas);

  double hitungTarif(int jml) => tarifDasar * jml * (kelas == "Bisnis" ? 1.5 : 1.0);
  void tampilInfo() => print ("Pesawat: $nama |Kelas: $kelas");
}

//Kelas Pemesanan
class Pemesanan{
  String idPemesanan, namaPelanggan;
  Transportasi transportasi;
  int jumlahPenumpang;
  double totalTarif;

  Pemesanan(this.idPemesanan, this.namaPelanggan, this.transportasi, this.jumlahPenumpang, this.totalTarif);

  void cetakStruk(){

  print("/n--- Struk Pemesanan---");
  print("ID : $idPemesanan");
  print("Nama : $namaPelanggan");
  transportasi.tampilInfo();
  print("Jumlah : $jumlahPenumpang");
  print("Total : ${totalTarif.toInt()}");
  print("------------------------");
  
}

Map<String, dynamic> toMap() =>{
  'idPemesanan' : idPemesanan,
  'nama' : namaPelanggan,
  'transportasi' : transportasi.nama,
  'penumpang' : jumlahPenumpang,
  'total' : totalTarif.toInt()

  };
}

//Fungsi Global

Pemesanan buatPemesanan(Transportasi t, String nama, int jml) 
=> Pemesanan ("P${DateTime.now().millisecondsSinceEpoch}", nama, t, jml, t.hitungTarif(jml));

void tampilkanSemuaPemesanan(List<Pemesanan>daftar)
=> daftar.forEach((p)=> p.cetakStruk());

//Fungsi Main

void main (){
  var taksi = Taksi("T01", "Taksi BlueBird", 5000, 4, 10);
  var bus = Bus("B01", "Bus TransJakarta", 3000, 40 , true);
  var pesawat = Pesawat("P01", "Garuda Indonesia", 150000, 100, "Bisnis");

  var daftarPemesanan = [
    buatPemesanan (taksi, "Amel", 1),
    buatPemesanan(bus, "Fira", 1) ,
    buatPemesanan(pesawat, "Chindy", 2)
  ];

  tampilkanSemuaPemesanan(daftarPemesanan);
}
