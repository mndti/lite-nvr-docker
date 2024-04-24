# lite-nvr-docker
- NVR simples para ser usado com o docker através de uma imagem alpine e ffmpeg
- Este projeto foi criado para uso pessoal e decidi compartilhar.

## Como usar?
Baixe a pasta scripts para seu host(windows/linux/etc).
Dentro do host, coloque a pasta com os scripts, onde achar melhor.
Antes, configure as informações no arquivo: **nvr.conf.json**

## Quantas câmeras posso usar?
O script não tem limitação de câmeras, basta adicionar no **nvr.conf.json**
Exemplo:
<pre><code>		{
		  "name": "_cam-1",
		  "name_ha":"nvr_cam_1",
		  "name_ha_friendly":"nvr - cam 1",
		  "ha_icon":"mdi:record-rec",
		  "link": "rtsp://user:pass@ip:554/Streaming/Channels/101"
		},</code></pre>

## Homeassistant
Se você não tiver ou não quiser usar o ha, ignore as configs relacionadas e use `"ha_status": false`
Essa config apenas cria sensores no ha com o status ok/problema. Se desativado, arquivos txt serão usados na pasta path_log.

## Qual o uso de CPU/RAM?
Baixo, pois o script apenas faz o copy do fluxo de vídeo/áudio. Entretanto, se desejar customizar os parametros do ffmpeg, edite o arquivo: `ffmpeg.sh`

