Hey Awanish, this is expected. The TLS certificates are issued by our Vault PKI which currently uses a self-signed root CA. Browsers don't trust it because it's not part of the corporate CA chain.

This is already on the roadmap — the plan is to swap the Vault PKI intermediate to the Calix corporate CA. That requires IT to sign our intermediate CSR. Once that's done, all certificates issued by Vault will be trusted by browsers automatically.

In the meantime, the connection is still encrypted — the "Not Secure" warning is about trust, not encryption. You can proceed past the warning safely.

I'll close the ticket with this context.
