public class MyFirstJavaProgram {

    private static String intToString(int number) {
        String jednosciDict[] = { "", "jeden", "dwa", "trzy", "cztery", "pięć", "sześć", "siedem", "osiem",
            "dzewięć" };
        String nascieDict[] = { "", "jedenaście", "dwanaście", "czternaście", "pietnaście", "siedamnaście",
            "osimnaście", "dziewietnaście" };
        String dziesiatkiDict[] = { "", "dziesięć", "dwadzieścia", "trzydzieści", "czterdzieści", "piećdziesiąt",
            "sześćdziesiąt", "siedemdziesiąt", "osiemdziesiąt", "dziewięćdziesiąt" };
        String setkiDict[] = { "", "sto", "dwieście", "trzysta", "czterysta", "pięćset", "sześćset", "siedemset", 
            "osimset", "dziewięćset" };

        String koncowki[][] = { { "", "", "" }, { "tysiąc", "tysiące", "tysięcy" }, { "milion", "miliony", "milionów" },
                { "miliard", "miliardy", "miliardów" }, { "bilion", "biliony", "bilionów" },
                { "biliard", "biliardy", "biliardów" } };

        String resoult = new String();
        String znak = new String();

        if (number < 0) {
            znak = "minus";
            number = -number;
        }

        int jednosci = 0, dziesiatki = 0, setki = 0, nastki = 0, formaGramatyczna = 0, g=0;

        while (number != 0) {
            setki = (number % 1000) / 100;
            dziesiatki = (number % 100) / 10;
            jednosci = number % 10;

            if(dziesiatki == 1 && jednosci > 0){
                nastki = jednosci;
                dziesiatki = 0;
                jednosci = 0;
            }
            else{
                nastki = 0;
            }

            if(jednosci == 1 && setki + dziesiatki + nastki == 0 ){
                formaGramatyczna = 0;

                if(setki + dziesiatki== 0 && g>0){
                    jednosci = 0;
                    resoult = koncowki[g][formaGramatyczna] + resoult;
                }
            }
            else if (jednosci == 2 || jednosci == 3 || jednosci == 4){
                formaGramatyczna = 1;
            }
            else {
                formaGramatyczna = 2;
            }

            if (jednosci + dziesiatki + setki + nastki >0){
                resoult = String.format("%s %s %s %s %s ",setkiDict[setki], dziesiatkiDict[dziesiatki], nascieDict[nastki], jednosciDict[jednosci], koncowki[g][formaGramatyczna]) + resoult;
            }
            g++;
            number = number / 1000;
             
        }
        resoult = znak + resoult;
        return resoult;
    }

    public static void main(String[] args) {

        for (int i = 0; i < args.length; i++) {

            try {
                int x = Integer.valueOf(args[i]);
                String number_string = intToString(x);
                System.out.println(number_string);
            } catch (NumberFormatException exception) {
                System.err.println("Exception throw: " + exception);
            }

        }
    }
}