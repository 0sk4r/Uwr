function validatePesel(x) {
    var wagi = [9,7,3,1,9,7,3,1,9,7];
   var suma = 0;
    
   for(var i=0;i<wagi.length;i++) {
       suma+=(parseInt(x.substring(i,i+1),10) * wagi[i]);
   }
   suma=suma % 10;
   var valid=(suma===parseInt(x.substring(10,11),10));
   if(valid)
   {
       return true;
   } else{
       return false;
   }

    }

    function NRBvalidatior(nrb)
  {
    nrb = nrb.replace(/[^0-9]+/g,'');
    var Wagi = new Array(1,10,3,30,9,90,27,76,81,34,49,5,50,15,53,45,62,38,89,17,
            73,51,25,56,75,71,31,19,93,57);
 
    if(nrb.length == 26) {
      nrb = nrb + "2521";
      nrb = nrb.substr(2) + nrb.substr(0,2);
      var Z =0;
      for (var i=0; i<30;i++) {
        Z += nrb[29-i] * Wagi[i];
      }
      if (Z % 97 == 1) {
        return true;
      }else{
        return false;
      }
 
    }else{
      return false;
    }
  }

  function validateEmail(email) {
    var re = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    return re.test(email);
}

    function validateDate(data,pesel)
    {
    var rok=parseInt(pesel.substring(0,2),10);
    var miesiac = parseInt(pesel.substring(2,4),10)-1;
   var dzien = parseInt(pesel.substring(4,6),10);

   if(miesiac>80) {
        rok = rok + 1800;
        miesiac = miesiac - 80;
   }
   else if(miesiac > 60) {
        rok = rok + 2200;
        miesiac = miesiac - 60;
   }
   else if (miesiac > 40) {
        rok = rok + 2100;
        miesiac = miesiac - 40;
   }
   else if (miesiac > 20) {
        rok = rok + 2000;
        miesiac = miesiac - 20;
   }
   else
   {
        rok += 1900;
   }
   var urodzony=new Date(rok,miesiac,dzien);
   var data1 = new Date(data);
   console.log(data1);
   console.log(urodzony);
   if(urodzony.getDate()==data1.getDate() && urodzony.getMonth() == data1.getMonth() && urodzony.getYear()== data1.getYear())
   {
       alert("data poprawna");
   }
   else{
       alert("data niepoprawna");
   }

    }

  function validateForm()
  {
    var konto = document.getElementById("konto").value;
    if (NRBvalidatior(konto)==true) {
        alert('nr. konta poprawny');
    }
    else {
        alert('nr. kotna niepoprawny');
    }
    var pesel = document.getElementById("pesel").value;
    if (validatePesel(pesel))
    {
        alert('pesel poprawny');
    }
    else{
        alert('pesel niepoprawny');
    }
    var email = document.getElementById("email").value;
    if (validateEmail(email)==true)
    {
        alert("email poprawny");
    }
    else{alert("email niepoprawny")};
    var data = document.getElementById("data").value;
    validateDate(data,pesel)


  }
