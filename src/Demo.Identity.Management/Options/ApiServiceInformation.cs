namespace Demo.Identity.Management.Options
{
    public record ApiServiceInformation()
    {
        public string Name { get; init; }
        public string Version { get; init; }
        public string Identifier { get; init; }
    }
}
