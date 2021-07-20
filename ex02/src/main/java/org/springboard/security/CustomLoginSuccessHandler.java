package org.springboard.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.SavedRequestAwareAuthenticationSuccessHandler;

import lombok.extern.log4j.Log4j;

@Log4j
public class CustomLoginSuccessHandler extends SavedRequestAwareAuthenticationSuccessHandler{
	
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication auth) throws IOException, ServletException {
		
        HttpSession session = request.getSession();

		if (session != null) {
			
            String redirectUrl = (String) session.getAttribute("prevPage");
            
            log.info(redirectUrl + " 이전페이지");
            
            if (redirectUrl != null) {
            	
                session.removeAttribute("prevPage");
                getRedirectStrategy().sendRedirect(request, response, redirectUrl);
                
            } else {
            	
            	super.onAuthenticationSuccess(request, response, auth);
            	
            }
        } else {
        	
            super.onAuthenticationSuccess(request, response, auth);
            
        }
		
	}
	
	
}
