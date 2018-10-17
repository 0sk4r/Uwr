package struktury;

import java.util.ArrayList;

/**
 * Implementacja zbioru z wykorzysatniem ArrayList
 */
public class ZbiorNaTablicyDynamicznej extends ZbiorNaTablicy {

    private ArrayList<Para> tablica;

    public ZbiorNaTablicyDynamicznej(int size) throws Exception {
        this.tablica = new ArrayList<>(size);

    }

    public ZbiorNaTablicyDynamicznej(){
        this.tablica = new ArrayList<>();
    }

    @Override
    public void czysc() {
        this.tablica = new ArrayList<>();
    }

    @Override
    public void ustaw(Para p) throws Exception {
        for (Para px : this.tablica) {
            if(p.equals(px)) {
                px.setWartosc(p.getWartosc());
                return;
            }
        }
        this.tablica.add(p);
    }

    @Override
    public void wstaw(Para p) throws Exception {
        if(this.ile() - 1 == this.tablica.size()) {
            this.tablica.ensureCapacity(2 * this.tablica.size());
        }
        this.tablica.add(p);
    }

    @Override
    public Para szukaj(String k) throws Exception {
        for (Para p : this.tablica) {
            if(p.klucz == k)
                return p;
        }
        throw new Exception("Nie znaleziono pary");
    }

    @Override
    public double czytaj(String k) throws Exception {
        for (Para p : this.tablica) {
            if(p.klucz == k)
                return p.getWartosc();
        }
        throw new Exception("Nie znaleziono pary");
    }

    @Override
    public int ile() {
        int licznik=0;

        for(Para p : this.tablica){
            if(p != null) licznik++;
        }
        return licznik;
    }
}
