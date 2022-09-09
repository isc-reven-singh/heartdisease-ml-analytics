Class App.Installer
{

XData setup
{
<Manifest>
  
  <Default Name="Namespace" Value="HEARTAPP"/>
  <Default Name="app" Value="heartapp" />
  <Default Name="SourceDir" Value="#{$system.Process.CurrentDirectory()}src/HeartApp"/>

  <Namespace Name="${Namespace}" Code="${Namespace}" Data="${Namespace}" Create="yes" Ensemble="1">

    <Configuration>
      <Database Name="${Namespace}" Dir="/opt/${app}/data" Create="yes" Resource="%DB_${Namespace}"/>
    </Configuration>
    <Import File="${SourceDir}" Flags="ck" Recurse="1"/>
    <CSPApplication Url="/csp/${app}" Directory="${cspdir}${app}"  ServeFiles="1" Recurse="1" MatchRoles=":%DB_${Namespace}" AuthenticationMethods="32"
       
    />
    <CSPApplication
            Url="/heartapp"
            Directory="${cspdir}${app}REST"
            DispatchClass="HeartApp.REST.Server"
            AuthenticationMethods="32"
        />
  </Namespace>

</Manifest>
}

ClassMethod setup(ByRef pVars, pLogLevel As %Integer = 3, pInstaller As %Installer.Installer, pLogger As %Installer.AbstractLogger) As %Status [ CodeMode = objectgenerator, Internal ]
{
  #; Let XGL document generate code for this method. 
  Quit ##class(%Installer.Manifest).%Generate(%compiledclass, %code, "setup")
}

}
