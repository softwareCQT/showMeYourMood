package com.softwareone.app.security.util;

import org.bouncycastle.jce.provider.BouncyCastleProvider;
import org.bouncycastle.openssl.PEMKeyPair;
import org.bouncycastle.openssl.PEMParser;
import org.bouncycastle.openssl.jcajce.JcaPEMKeyConverter;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.security.Security;
import java.security.interfaces.RSAPrivateKey;
import java.security.interfaces.RSAPublicKey;


/**
 * @author chenqiting
 * 单例加载jwt文件得到key
 */
public class RsaKeyUtil {
    private final static Logger logger = LoggerFactory.getLogger(RsaKeyUtil.class);

    private RSAPrivateKey rsaPrivateKey;
    private RSAPublicKey rsaPublicKey;

    private RsaKeyUtil() {
        try {
            loadKeyFile();
        } catch (IOException e) {
            logger.error("加载jwtKey文件失败");
        }
    }

    private static class RasKeyUtilHolder {
        private static final RsaKeyUtil INSTANCE = new RsaKeyUtil();
    }

    public static RsaKeyUtil getInstance() {
        return RasKeyUtilHolder.INSTANCE;
    }

    private void loadKeyFile() throws IOException {
        BufferedReader br = new BufferedReader(
                new InputStreamReader(this.getClass().getResourceAsStream("/jwtKey")));
        Security.addProvider(new BouncyCastleProvider());
        PEMKeyPair kp = (PEMKeyPair) new PEMParser(br).readObject();

        JcaPEMKeyConverter converter = new JcaPEMKeyConverter();
        this.rsaPrivateKey = (RSAPrivateKey) converter.getPrivateKey(kp.getPrivateKeyInfo());
        this.rsaPublicKey = (RSAPublicKey) converter.getPublicKey(kp.getPublicKeyInfo());
    }

    public RSAPrivateKey getRsaPrivateKey() {
        return this.rsaPrivateKey;
    }

    public RSAPublicKey getRsaPublicKey() {
        return this.rsaPublicKey;
    }

}
