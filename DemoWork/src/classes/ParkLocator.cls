public class ParkLocator {
            public static string[] country(String country) {
                parkService.ParksImplPort park = new parkService.ParksImplPort();
                return park.byCountry(country);
            }
}