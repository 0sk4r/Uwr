package struktury;

/**
 * Implementacja zbioru z wykorzysatniem tablicy
 */
public class ZbiorNaTablicy extends Zbior {
    private Para[] tablica;
    private int last;

    public ZbiorNaTablicy(int size) throws Exception {
        if(size >= 2) {
            this.tablica = new Para[size];
            this.last = 0;
        }
        else{
            throw new Exception("Za mały rozmiar");
        }
    }

    public ZbiorNaTablicy() {

    }

    public Para szukaj(String k) throws Exception {
        for (Para p : this.tablica) {
            if(p.klucz == k)
                return p;
        }
        throw new Exception("Nie znaleziono pary");
    }

    @Override
    public void wstaw(Para p) throws Exception {
        try{
            this.szukaj(p.klucz);
            throw new Exception("Ten sam element");
        }
        catch(Exception e){
            if(this.last != tablica.length) {
                this.tablica[this.last] = p;
                this.last++;
            }
            else{
                throw new Exception("Brak miejsca");
            }
        }
    }

    @Override
    public double czytaj(String k) throws Exception {
        Para p = this.szukaj(k);
        return p.getWartosc();
    }

    @Override
    public void ustaw(Para p) throws Exception {
        for (Para px : this.tablica) {
            if(p.equals(px)) {
                px.setWartosc(p.getWartosc());
                return;
            }
        }

        this.wstaw(p);
    }

    @Override
    public void czysc() {
        for(int i = 0; i < this.tablica.length; i++){
            this.tablica[i] = null;
        }
        this.last = 0;
    }

    @Override
    public int ile() {
        return this.last;
    }
}
