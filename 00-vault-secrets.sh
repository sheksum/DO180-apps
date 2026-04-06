hey i know you're out today so just dropping a note here for Monday, did a couple things today.

on plnx-vault, I copied over the Calix CA chain to /etc/pki/ca-trust/source/anchors/ and ran update-ca-trust It will save you from having to run export VAULT_SKIP_VERIFY=true all the time when operating there locally.

I added that signed ca cert (with the full chain) to vault via:

[root@plnx-vault ~]# vault write pki_int/intermediate/set-signed certificate=@calix-local-chain.pem
Key                 Value
---                 -----
existing_issuers    <nil>
existing_keys       <nil>
imported_issuers    [607ba730-8951-e16d-44e4-e49b853669b0 c07ee43a-517b-4404-e4f4-da4f951e1d2e 05261746-481f-2842-13de-13a1f17aa98c 28fe332e-56ba-1fd3-d619-49435d6881c8]
imported_keys       <nil>
mapping             map[05261746-481f-2842-13de-13a1f17aa98c: 28fe332e-56ba-1fd3-d619-49435d6881c8: 607ba730-8951-e16d-44e4-e49b853669b0:a6727a6b-43ac-9de8-086f-de5ee743c128 c07ee43a-517b-4404-e4f4-da4f951e1d2e:]

I now see the 2 sets of issuers.  We'll probably want to clean that old ocp-ai issuer up, and update that ocp-ai role, and maybe is going to need some work on the k8s side as well to reconfigure the cert-manager issuer config

Even though no one is really using that yet, figured it be best to wait til next week to work on any of that, and not sure we should create a change record etc.. (edited)
