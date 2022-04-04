Clear-Host;

#https://stackoverflow.com/a/5466355/18457167
Set-Location $PSScriptRoot;

$usersFilePath = "./nom.csv";
$groupName = "Entreprise";

function CreateUser($name) {
  $user = Get-LocalUser | Where-Object Name -eq $name;

  if (!$user) {
    #$user = New-LocalUser -Name $name -FullName $name -Description "Compte pour $name";
    Write-Host "Création de l'utilisateur $name avec succès!";
  } else {
    Write-Host "Utilisateur $name déja éxistant!";
  }
}

function CreateGroup($name) {
  $group = Get-LocalGroup | Where-Object Name -eq $name;

  if (!$group) {
    $group = New-LocalGroup -Name $name -Description "Groupe pour le travail de JPD";
    Write-Host "Création du groupe $name avec succès!";
  } else {
    Write-Host "Groupe $name déja éxistant!";
  }
}

function init() {
  $file = Get-Item -Path $usersFilePath -ErrorAction Ignore;

  CreateGroup($groupName);

  if ($file) {
    $content = Get-Content $usersFilePath;
    foreach ($line in $content) {
       CreateUser($line);
    }
  } else {
    Write-Host "Le fichier $usersFilePath est introuvable!";
  }
}

init;


#CreateUser("nathan");