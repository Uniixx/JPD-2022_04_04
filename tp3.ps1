Clear-Host;

#https://stackoverflow.com/a/5466355/18457167
Set-Location $PSScriptRoot;

$usersFilePath = "./nom.csv";

function CreateUser($name) {
  $user = Get-LocalUser | Where-Object Name -eq $name;

  if (!$user) {
    $user = New-LocalUser -Name $name -FullName $name -Description "Compte pour $name";
    Write-Host "Création de l'utilisateur $name avec succès!";
  } else {
    Write-Host "Utilisateur déja éxistant!";
  }
}

function init() {
  $file = Get-Item -Path $usersFilePath -ErrorAction Ignore;

  if ($file) {
    $content = Get-Content $usersFilePath;
    foreach ($line in $content) {
       Write-Host ($line);
    }
  } else {
    Write-Host "Le fichier $usersFilePath est introuvable!"
  }
}

init;


#CreateUser("nathan");