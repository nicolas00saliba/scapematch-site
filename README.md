# scapematch-site

Site público do ScapeMatch em [scapematch.com.br](https://scapematch.com.br).

A fonte da landing fica em [`apps/landing`](https://github.com/nicolas00saliba/scapematch/tree/main/apps/landing) do repositório principal [`nicolas00saliba/scapematch`](https://github.com/nicolas00saliba/scapematch).

Hoje o GitHub Pages publica a partir da branch `main` (arquivos estáticos neste repositório). O workflow de sync horário a partir de `apps/landing` ainda não está no repositório: o token OAuth do `gh` nesta máquina não tem o scope `workflow` necessário para criar `.github/workflows/*.yml`. Quando o scope for liberado, o arquivo em `.github/workflows/deploy.yml` (cópia local) deve ser commitado e o Pages pode passar a `build_type=workflow`.

Não edite HTML/CSS aqui como fonte da verdade — altere no repositório principal e republice.
