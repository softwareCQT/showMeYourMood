package com.softwareone.app.security.util;

import com.auth0.jwt.JWT;
import com.auth0.jwt.JWTVerifier;
import com.auth0.jwt.algorithms.Algorithm;
import com.auth0.jwt.exceptions.JWTCreationException;
import com.auth0.jwt.exceptions.JWTVerificationException;
import com.auth0.jwt.interfaces.DecodedJWT;
import com.softwareone.app.constant.SystemConstant;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import java.security.interfaces.RSAPrivateKey;
import java.security.interfaces.RSAPublicKey;
import java.util.Date;

/**
 * @author chenqiting
 */
@Component
public class JwtUtil {
    @Value("${security.jwtDefaultExp}")
    Integer expTime;

    private static Algorithm algorithm;

    public JwtUtil() {
        RSAPublicKey publicKey = RsaKeyUtil.getInstance().getRsaPublicKey();
        RSAPrivateKey privateKey = RsaKeyUtil.getInstance().getRsaPrivateKey();
        algorithm = Algorithm.RSA256(publicKey, privateKey);
    }

    public String createToken(String userName, String userId) {
        String token;
        try {
            token = JWT
                    .create()
                    .withIssuer("ChenQiTing")
                    .withSubject(userName)
                    .withClaim("UserId", userId)
                    .withExpiresAt(new Date(System.currentTimeMillis() + Long.valueOf(this.expTime) * 1000L))
                    .sign(algorithm);
        } catch (JWTCreationException e) {
            return null;
        }
        return SystemConstant.BEARER + token;
    }

    public String getUuid(String token) {
        try {
            //解密
            JWTVerifier verifier = JWT.require(algorithm)
                    .withIssuer("ChenQiTing")
                    .build();
            DecodedJWT jwt = verifier.verify(token);
            return jwt.getSubject();
        } catch (JWTVerificationException exception) {
            return null;
        }
    }

    public Integer getUserId(String token) {
        Integer userId = null;
        try {
            JWTVerifier verifier = JWT.require(algorithm)
                    .withIssuer("ChenQiTing")
                    .build();
            DecodedJWT jwt = verifier.verify(token);
            userId = jwt.getClaim("UserId").asInt();
        } catch (JWTVerificationException exception) {
            exception.printStackTrace();
        }
        return userId;
    }
}
