import Foundation

public enum IdLocale {
    case english, norwegian, danish, swedish

    func brandName(idProvider: IdProvider) -> String {
        switch idProvider {
        case .telenorId:
            return "Telenor ID";
        case .gpId:
            return "GP ID";
        case .connectId:
            return "CONNECT";
        case .dtacId:
            return "DTAC ID";
        }
    }
    
    func networkName(idProvider: IdProvider) -> String {
        switch idProvider {
        case .telenorId:
            return "Telenor";
        case .gpId:
            return "Grameenphone";
        case .connectId:
            return "Telenor";
        case .dtacId:
            return "dtac";
        }
    }
       
    func aboutDescription(idProvider: IdProvider) -> String {
        switch self {
        case .english:
            return "Your \(self.brandName(idProvider: idProvider)) is used to log in to all apps and services.\u{0020}";
        case .norwegian:
            return "Din \(self.brandName(idProvider: idProvider)) kan brukes til å logge deg inn til alle apper og tjenester.\u{0020}";
        case .danish:
            return "Din \(self.brandName(idProvider: idProvider)) kan bruges til at logge ind på alle apps og tjenester.\u{0020}";
        case .swedish:
            return "Din \(self.brandName(idProvider: idProvider)) kan användas för att logga in på alla appar och tjänster.\u{0020}";
        }
    }
    
    func aboutLink() -> String {
        switch self {
        case .english:
            return "Learn more\u{00A0}\u{203A}";
        case .norwegian:
            return "Les mer\u{00A0}\u{203A}";
        case .danish:
            return "Læs mere\u{00A0}\u{203A}";
        case .swedish:
            return "Läs mer\u{00A0}\u{203A}";
        }
    }
    
    func aboutBack() -> String {
        switch self {
        case .english:
            return "\u{2039}\u{00A0}Back";
        case .norwegian:
            return "\u{2039}\u{00A0}Tilbake";
        case .danish:
            return "\u{2039}\u{00A0}Tilbage";
        case .swedish:
            return "\u{2039}\u{00A0}Tillbaka";
        }
    }
    
    func aboutScreenTitle(idProvider: IdProvider) -> String {
        switch self {
        case .english:
            return "What is \(self.brandName(idProvider: idProvider))?";
        case .norwegian:
            return "Hva er \(self.brandName(idProvider: idProvider))?";
        case .danish:
            return "Hvad er \(self.brandName(idProvider: idProvider))?";
        case .swedish:
            return "Vad är \(self.brandName(idProvider: idProvider))?";
        }
    }
    
    func aboutSlogan() -> String {
        switch self {
        case .english:
            return "One secure login for all services";
        case .norwegian:
            return "En sikker innlogging for alle tjenester";
        case .danish:
            return "En sikker login for alle tjenester";
        case .swedish:
            return "En säker inloggning för alla tjänster";
        }
    }
    
    func aboutParagraph1(idProvider: IdProvider) -> String {
        switch self {
        case .english:
            return "\(self.brandName(idProvider: idProvider)) provides users with a passwordless login for all apps and services.";
        case .norwegian:
            return "\(self.brandName(idProvider: idProvider)) tilbyr brukere en passordløs innlogging til alle apper og tjenester.";
        case .danish:
            return "\(self.brandName(idProvider: idProvider)) tilbyder brugere et adgangskodeløs login for alle apps og tjenester.";
        case .swedish:
            return "\(self.brandName(idProvider: idProvider)) erbjuder användare en lösenordsfri inloggning för alla appar och tjänster.";
        }
    }
    
    func aboutParagraph2(idProvider: IdProvider) -> String {
        switch self {
        case .english:
            return "\(self.networkName(idProvider: idProvider)) mobile subscribers enjoy additional security and convenience by having their phone numbers automatically recognised and verified by the \(self.networkName(idProvider: idProvider)) mobile network.";
        case .norwegian:
            return "\(self.networkName(idProvider: idProvider))s mobilabonnenter kan glede seg over ekstra sikkerhet og enkelhet når de logger inn, som følge av automatisk gjenkjenning og bekreftelse av mobilnummeret via \(self.brandName(idProvider: idProvider))s mobilnettverk.";
        case .danish:
            return "\(self.networkName(idProvider: idProvider))s mobilabonnenter kan nyde ekstra sikkerhed og enkelhed, når de logger ind, som følge af automatisk genkendelse og bekræftelse af mobilnummeret via \(self.brandName(idProvider: idProvider))s mobilnetværk.";
        case .swedish:
            return "\(self.networkName(idProvider: idProvider))s mobilabonnenter kan njuta av extra säkerhet och enkelhet när de loggar in, som ett resultat av automatisk igenkänning och verifiering av mobilnumret via \(self.brandName(idProvider: idProvider))s mobilnätverk.";
        }
    }
    
    func aboutParagraph3(idProvider: IdProvider) -> String {
        switch self {
        case .english:
            return "With risk-based authentication, \(self.brandName(idProvider: idProvider)) enhances user security by detecting unusual logins.";
        case .norwegian:
            return "Med risikobasert autentisering forbedrer \(self.brandName(idProvider: idProvider)) brukerens sikkerhet ved at uvanlige innlogginger avdekkes.";
        case .danish:
            return "Med risikobaseret autentificering forbedrer \(self.brandName(idProvider: idProvider)) brugerens sikkerhed, ved at afdække usædvanlige logins.";
        case .swedish:
            return "Med riskbaserad autentisering förbättrar \(self.brandName(idProvider: idProvider)) användarens säkerhet genom att upptäcka ovanliga inloggningar.";
        }
    }
    
    func aboutParagraph4(idProvider: IdProvider) -> String {
        switch self {
        case .english:
            return "An unusual login might be caused by logging in from a new location, or someone trying to fraudulently use your \(self.brandName(idProvider: idProvider)). In any case, the user will experience additional steps when logging in, in order to prevent abuse.";
        case .norwegian:
            return "En uvanlig innlogging kan være forårsaket av deg selv når du logger inn fra en ny lokasjon, eller en annen bruker som forsøker seg på uredelig bruk av din \(self.brandName(idProvider: idProvider)). I begge tilfellene vil brukeren oppleve ekstra steg i innloggingsflyten for å forhindre misbruk.";
        case .danish:
            return "En usædvanlig login kan skyldes dig selv når du logger ind fra en ny placering, eller en anden bruger, der forsøger at misbruge din \(self.brandName(idProvider: idProvider)). I begge tilfælde vil brugeren opleve yderligere trin i login-flowet, for at forhindre misbrug.";
        case .swedish:
            return "En ovanlig inloggning kan orsakas av dig själv när du loggar in från en ny plats eller av en annan användare som försöker missbruka din \(self.brandName(idProvider: idProvider)). I båda fallen kommer användaren att uppleva ytterligare steg i inloggningsflödet för att förhindra missbruk.";
        }
    }
    
    func aboutParagraph5(idProvider: IdProvider) -> String {
        switch self {
        case .english:
            return "Anyone can use \(self.brandName(idProvider: idProvider)), at no cost. You do not need to become a \(self.networkName(idProvider: idProvider)) subscriber.";
        case .norwegian:
            return "Alle kan bruke \(self.brandName(idProvider: idProvider)) gratis. Du trenger ikke å bli \(self.networkName(idProvider: idProvider))-abonnent.";
        case .danish:
            return "Alle kan bruge \(self.brandName(idProvider: idProvider)) gratis. Du behøver ikke at blive \(self.networkName(idProvider: idProvider))-abonnent.";
        case .swedish:
            return "Vem som helst kan använda \(self.brandName(idProvider: idProvider)) gratis. Du behöver inte bli \(self.networkName(idProvider: idProvider))-abonnent.";
        }
    }
    
    func aboutParagraph6(idProvider: IdProvider) -> String {
        switch self {
        case .english:
            return "For higher risk logins, \(self.brandName(idProvider: idProvider)) can request a password as an additional step.";
        case .norwegian:
            return "Ved innlogginger som har en høyere risiko, kan \(self.brandName(idProvider: idProvider)) forespørre passord som et ekstra steg i innloggingen.";
        case .danish:
            return "For logins, der har en højere risiko, kan \(self.brandName(idProvider: idProvider)) anmode adgangskode som et yderligere trin i login-flowet.";
        case .swedish:
            return "För inloggningar som visar en högre risk, kan \(self.brandName(idProvider: idProvider)) begära lösenord som ett ytterligare steg i inloggningen.";
        }
    }
}
