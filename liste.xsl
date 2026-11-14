<?xml version="1.0" encoding="UTF-8"?>
<!-- matricule — Nom Prénom : à compléter avant le rendu -->
<xsl:stylesheet version="1.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html" encoding="UTF-8" indent="yes"/>
  <xsl:template match="/">
    <html>
      <head><meta charset="UTF-8"/><title>Liste des étudiants</title></head>
      <body>
        <h1>Liste des étudiants</h1>
        <ul><xsl:apply-templates select="promotion/etudiant"/></ul>
      </body>
    </html>
  </xsl:template>
  <xsl:template match="etudiant">
    <li><xsl:value-of select="prenom"/> <xsl:text> </xsl:text><xsl:value-of select="nom"/></li>
  </xsl:template>
</xsl:stylesheet>
