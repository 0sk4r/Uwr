public class Zad1 {

    private static String intToString(int number) {
        String unitsDict[] = { "", "jeden ", "dwa ", "trzy ", "cztery ", "pięć ", "sześć ", "siedem ", "osiem ",
            "dzewięć " };
        String specialNum[] = { "", "jedenaście ", "dwanaście ", "czternaście ", "pietnaście ", "siedamnaście",
            "osimnaście ", "dziewietnaście " };
        String tensDict[] = { "", "dziesięć ", "dwadzieścia ", "trzydzieści ", "czterdzieści ", "piećdziesiąt ",
            "sześćdziesiąt ", "siedemdziesiąt ", "osiemdziesiąt ", "dziewięćdziesiąt " };
        String hundredsDict[] = { "", "sto ", "dwieście ", "trzysta ", "czterysta ", "pięćset ", "sześćset ", "siedemset ", 
            "osimset ", "dziewięćset " };

        String scaleUnit[][] = { { "", "", "" }, { "tysiąc ", "tysiące ", "tysięcy " }, { "milion ", "miliony ", "milionów " },
                { "miliard ", "miliardy ", "miliardów " }, { "bilion ", "biliony ", "bilionów " },
                { "biliard ", "biliardy ", "biliardów " } };

        String resoult = new String();
        String sign = new String();

        if (number < 0) {
            sign = "minus";
            number = -number;
        }
        else if (number == 0){
            return "zero";
        }

        int units = 0, tens = 0, hundreds = 0, nastki = 0, scale = 0, g=0;

        while (number != 0) {
            hundreds = (number % 1000) / 100;
            tens = (number % 100) / 10;
            units = number % 10;

            if(tens == 1 && units > 0){
                nastki = units;
                tens = 0;
                units = 0;
            }
            else{
                nastki = 0;
            }

            if(units == 1 && hundreds + tens + nastki == 0 ){
                scale = 0;

                if(hundreds + tens== 0 && g>0){
                    units = 0;
                    resoult = scaleUnit[g][scale] + resoult;
                }
            }
            else if (units == 2 || units == 3 || units == 4){
                scale = 1;
            }
            else {
                scale = 2;
            }

            if (units + tens + hundreds + nastki >0){
                resoult = String.format("%s%s%s%s%s ",hundredsDict[hundreds], tensDict[tens], specialNum[nastki], unitsDict[units], scaleUnit[g][scale]) + resoult;
            }
            g++;
            number = number / 1000;
             
        }
        resoult = sign + resoult;
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