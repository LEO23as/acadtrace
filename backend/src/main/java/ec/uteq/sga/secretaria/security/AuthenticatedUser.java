package ec.uteq.sga.secretaria.security;

import java.util.List;

/**
 * Equivalente a req.user en el middleware Node (username + roles del JWT).
 */
public record AuthenticatedUser(String username, List<String> roles) {

    public static final String REQUEST_ATTRIBUTE = "authenticatedUser";
}
