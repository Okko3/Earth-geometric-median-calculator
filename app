
double[] lats = {};
double guesslat = 
double guesslong = 

for (int i = 0; i < 5000; i++)
{
    double Totaldistnorth = 0;
    double Totaldistsouth = 0;
    double Totaldisteast = 0;
    double Totaldistwest = 0;

    for (int j = 0; j < lats.Length; j++)
    {
        double guessnorth = guesslat + 0.001;
        Totaldistnorth = Totaldistnorth + DistanceTo(lats[j], longs[j], guessnorth, guesslong);  
// Luodaan aloituspisteen lähistölle neljä uutta pistettä ja lasketaan kokonaisetäisyys paikkakunnista

        double guesssouth = guesslat - 0.001;
        Totaldistsouth = Totaldistsouth + DistanceTo(lats[j], longs[j], guesssouth, guesslong);

        double guesseast = guesslong + 0.001;
        Totaldisteast = Totaldisteast + DistanceTo(lats[j], longs[j], guesslat, guesseast);

        double guesswest = guesslong - 0.001;
        Totaldistwest = Totaldistwest + DistanceTo(lats[j], longs[j], guesslat, guesswest); 

    }
    if (Totaldistnorth < Totaldistsouth && Totaldistnorth < Totaldistwest && Totaldistnorth < Totaldisteast)
    {
        guesslat = guesslat + 0.001;
    }
    else if (Totaldistsouth < Totaldistnorth && Totaldistsouth < Totaldistwest && Totaldistsouth < Totaldisteast)
    {
        guesslat = guesslat - 0.001;
    } 
    else if (Totaldistwest < Totaldistsouth && Totaldistwest < Totaldisteast && Totaldistwest < Totaldistnorth)
    {
        guesslong = guesslong - 0.001;
    }
    else
    {
        guesslong = guesslong + 0.001; // Katsotaan mihin neljästä pisteestä on lyhin matka ja tehdään lyhimmän matkan pisteestä uusi aloituspiste
    }

   


}

Console.WriteLine(guesslong);
Console.WriteLine(guesslat);

static double DistanceTo(double lat1, double lon1, double lat2, double lon2, char unit = 'K')   
 // Kaava koordinaattien välisien etäisyyksien laskemiseen
{
    double rlat1 = Math.PI * lat1 / 180;
    double rlat2 = Math.PI * lat2 / 180;
    double theta = lon1 - lon2;
    double rtheta = Math.PI * theta / 180;
    double dist =
        Math.Sin(rlat1) * Math.Sin(rlat2) + Math.Cos(rlat1) *
        Math.Cos(rlat2) * Math.Cos(rtheta);
    dist = Math.Acos(dist);
    dist = dist * 180 / Math.PI;
    dist = dist * 60 * 1.1515;

    switch (unit)
    {
        case 'K': //Kilometers -> default
            return dist * 1.609344;
        case 'N': //Nautical Miles 
            return dist * 0.8684;
        case 'M': //Miles
            return dist;
    }

    return dist;
}

