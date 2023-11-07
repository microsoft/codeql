
void test00(int n) {
  int i = 0;
  if (n <= 0) {
    return;
  }
  while (1) {
    // BAD: condition is never true, so loop will not terminate.
    if (i == n) {
      break;
    }
  }
}

void test01(int n) {
  int i = 0;
  if (n <= 0) {
    return;
  }
  for (;;) {
    // BAD: condition is never true, so loop will not terminate.
    if (i == n) {
      break;
    }
  }
}

void test02(int n) {
  int i = 0;
  if (n <= 0) {
    return;
  }
  while (1) {
    // GOOD: condition is true after n iterations.
    if (i == n) {
      break;
    }
    i++;
  }
}

void test03(int n) {
  int i = 0;
  // GOOD: obviously infinite, so presumably deliberate.
  while (1) {
    i++;
  }
}

void test04(int n) {
  int i = 0;
  // GOOD: obviously infinite, so presumably deliberate.
  for (;;) {
    i++;
  }
}

int test05() {
  int i = 0;
  int result = 0;

  // BAD: loop condition is always true.
  for (i = 0; i >= 0; i = (i + 1) % 256)
  {
    result++;
  }
  return result;
}

int test06() {
  int i = 0;
  int result = 0;

  for (i = 0; i >= 0; i = (i + 1) % 256)
  {
    // GOOD: this condition is satisfiable.
    if (i == 10)
    {
      break;
    }
    result++;
  }
  return result;
}

int test07()
{
  int i = 0;
  int result = 0;

  // GOOD: this condition is satisfiable.
  for(i = 0; i < 11; i = (i + 1) % 256)
  {
    result++;
  }
  return result;
}

void test08(int n) {
  int i, j;
  if (n <= 0) {
    return;
  }

  // The function exit is unreachable from this loop, even though it
  // terminates. We should not report a result for this loop because this
  // loop is not responsible for the problem.
  for (i = 0; i < n; i++) {}

  for (i = 0;;) {
    // BAD: condition is never true, so loop will not terminate.
    if (i == n) {
      break;
    }

    // Another loop which is not responsible for the problem.
    for (j = 0; j < n; j++) {}
  }
}

void test09(char *str) {
  char c;

  while (true)
  {
    c = *(str++);

    if (c < 'a' && c > 'z') // BAD: this condition is always false.
      return;
  }
}

void test10(char *str) {
  char c;

  while (true)
  {
    c = *(str++);

    if (c < 'a' || c > 'z') // GOOD: this condition is satisfiable.
      return;
  }
}

void test11(int iterations)
{
    // Profile profile;
    // profile.RoutingMethod = RoutingMethod::Geographic;
    // profile.TimeToLiveInSeconds = this->GenerateRandomTtl();

    // const auto& mappings = this->addressToRegionHierarchyMap.GetRegionHierarchyMappings();
    for (int i = 0; i < iterations; i++)
    {
        // uint64_t index = this->GenerateRandomValue(0, mappings.size() - 1);
        // const auto& pair = mappings[index];
        // const AddressRange& range = pair.first;
        // const AddressToRegionHierarchyMap::RegionCodes& regionCodes = pair.second;
        const int regionCodes[4] = {1,2,3,4};

        for (const auto& region : regionCodes)
        {
            const int maxEndpoints = 5;
            // profile.Endpoints.clear();

            for (int endpointIndex = 0; endpointIndex < maxEndpoints; endpointIndex++)
            {
                //std::ostringstream os;
                //os << endpointIndex;

                // Endpoint endpoint;
                // endpoint.ResourceName = os.str();
                // endpoint.RecordType = RecordType::CanonicalName;
                // endpoint.Health = Health::Healthy;
                // endpoint.CanonicalName = os.str();

                // AddressToRegionHierarchyMap::RegionCodes regionHierarchy{ region };
                // endpoint.Regions = bond::maybe<std::vector<std::string>>(regionHierarchy);

                // profile.Endpoints.push_back(endpoint);
            }

            // std::set<std::string> endpointsHit;
            // while (endpointsHit.size() < profile.Endpoints.size())
            // {
            //     Address randomAddress = this->GenerateRandomAddress(range);
            //     Transaction transaction(this->GetPolicyProvider(), "test.net", profile);
            //     transaction.SetAddress(randomAddress);

            //     PolicyProviderResultCode resultCode = transaction.Execute();

            //     Assert::AreEqual((int)PolicyProviderResultCode::Success, (int)resultCode);
            //     Assert::IsNotNull(transaction.GetResult());
            //     Assert::AreEqual(0u, transaction.GetResult()->ClientSubnetLength);
            //     Assert::AreEqual((int)PolicyProviderOutputFlags::CollapseCname, (int)transaction.GetResult()->Flags);

            //     const PolicyProviderRecord& record = transaction.GetResult()->Records[0];
            //     std::string target(record.RecordData.CNAME.Target);

            //     TraceVerbose(
            //         "TestPolicyProvider-TestSelectOneOfMatchingEndpointsByGeography-Endpoint",
            //         Tlv(randomAddress.ToString().c_str(), "address"),
            //         Tlv(region.c_str(), "region"),
            //         Tlv(record.RecordData.CNAME.Target, "endpoint"));

            //     endpointsHit.insert(target);
            // }
        }
    }
}
