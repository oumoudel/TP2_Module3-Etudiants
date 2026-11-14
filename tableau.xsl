<?xml version="1.0" encoding="UTF-8"?>
<!-- matricule — Nom Prénom : à compléter avant le rendu -->
<xsl:stylesheet version="1.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html" encoding="UTF-8" indent="yes"/>
  <xsl:param name="seuil" select="10"/>
  <xsl:key name="par-classe" match="etudiant" use="@classe"/>

  <xsl:template match="/">
    <html>
      <head>
        <meta charset="UTF-8"/>
        <title><xsl:value-of select="promotion/@filiere"/> - Résultats</title>
        <link rel="stylesheet" href="style.css"/>
      </head>
      <body>
        <header>
          <h1>Résultats de la promotion</h1>
          <p><xsl:value-of select="promotion/@filiere"/> — Année <xsl:value-of select="promotion/@annee"/></p>
        </header>
        <main>
          <div class="stats">
            <div class="carte"><span class="valeur"><xsl:value-of select="count(promotion/etudiant)"/></span><span class="legende">Nombre d'étudiants</span></div>
            <div class="carte"><span class="valeur"><xsl:value-of select="count(promotion/etudiant[(sum(notes/note) div count(notes/note)) &gt;= $seuil])"/></span><span class="legende">Nombre d'admis</span></div>
            <div class="carte"><span class="valeur"><xsl:value-of select="format-number(sum(promotion/etudiant/notes/note) div count(promotion/etudiant/notes/note), '0.00')"/></span><span class="legende">Moyenne générale des notes XML</span></div>
            <div class="carte"><span class="valeur"><xsl:value-of select="count(promotion/etudiant[not(email)])"/></span><span class="legende">Emails manquants</span></div>
          </div>

          <xsl:for-each select="promotion/etudiant[generate-id() = generate-id(key('par-classe', @classe)[1])]">
            <xsl:variable name="classe" select="@classe"/>
            <h2><xsl:value-of select="$classe"/> — <xsl:value-of select="count(key('par-classe', $classe))"/> étudiants</h2>
            <table>
              <thead><tr>
                <th>Rang</th><th>Matricule</th><th>Nom</th><th>Prénom</th><th>Classe</th><th>Email</th><th>Moyenne</th><th>Résultat</th>
              </tr></thead>
              <tbody>
                <xsl:for-each select="key('par-classe', $classe)">
                  <xsl:sort select="sum(notes/note) div count(notes/note)" data-type="number" order="descending"/>
                  <tr>
                    <xsl:if test="position() = 1"><xsl:attribute name="class">major</xsl:attribute></xsl:if>
                    <td class="rang"><xsl:value-of select="position()"/></td>
                    <td><xsl:value-of select="@matricule"/></td>
                    <td><xsl:value-of select="nom"/></td>
                    <td><xsl:value-of select="prenom"/></td>
                    <td><xsl:value-of select="@classe"/></td>
                    <td>
                      <xsl:choose>
                        <xsl:when test="email"><xsl:value-of select="email"/></xsl:when>
                        <xsl:otherwise><span class="absent">non renseigné</span></xsl:otherwise>
                      </xsl:choose>
                    </td>
                    <td class="moyenne"><xsl:value-of select="format-number(sum(notes/note) div count(notes/note), '0.00')"/></td>
                    <td>
                      <xsl:choose>
                        <xsl:when test="(sum(notes/note) div count(notes/note)) &gt;= $seuil"><span class="badge reussite">Admis</span></xsl:when>
                        <xsl:otherwise><span class="badge echec">À revoir</span></xsl:otherwise>
                      </xsl:choose>
                    </td>
                  </tr>
                </xsl:for-each>
              </tbody>
            </table>
          </xsl:for-each>
        </main>
        <footer>TP XML — XPath, XSLT et CSS</footer>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
